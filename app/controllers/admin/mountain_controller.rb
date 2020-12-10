class Admin::MountainController < ApplicationController
  before_action :if_not_admin
  before_action :set_mountain, only: [:show, :edit, :destroy]

  private

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_restaurant
    @mountain = Mountain.find(params[:id])
  end

end
