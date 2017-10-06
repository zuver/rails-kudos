class OrganizationsController < ApplicationController
  # GET /organizations
  def index
    @organizations = Organization.all
    render json: @organizations, status: :ok
  end
end
