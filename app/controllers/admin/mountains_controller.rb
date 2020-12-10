class Admin::MountainsController < ApplicationController
  before_action :authenticate_user!
  before_action :if_not_admin

  def index
    @m = Mountain.ransack(params[:q])
    @results = @m.result.includes(:area, :elevation, :climb_time)
    set_column
  end

  private

  def if_not_admin
    redirect_to pages_top_path unless current_user.admin?
  end

  def set_column
    @area = Area.all
    @elevation = Elevation.all
    @climb_time = ClimbTime.all
  end
end
