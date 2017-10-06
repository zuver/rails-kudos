class AddOrganizationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :organization_id, :integer
    add_index :users, :organization_id
  end
end
