# == Schema Information
#
# Table name: kudos
#
#  id          :integer          not null, primary key
#  giver_id    :integer
#  receiver_id :integer
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'User', counter_cache: :kudos_given_count, inverse_of: :kudos_given
  belongs_to :receiver, class_name: 'User', counter_cache: :kudos_received_count, inverse_of: :kudos_received

  validates_presence_of :giver_id, :receiver_id
  validates :text, length: { maximum: 140 }
  validate :per_minute_limit, :on => :create # Checks if a user has given too many Kudos recently

  private

  def per_minute_limit
    # Checks if a user has given more than three Kudos in the past minute
    if giver.kudos_given.where(:created_at => (1.minutes.ago..Time.current)).count >= 3
      errors.add(:base, 'A user may give Kudos up to three times per minute')
    end
  end
end
