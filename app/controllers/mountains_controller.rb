class MountainsController < ApplicationController
  before_action :authenticate_user!

  def index
    @m = Mountain.ransack(params[:q])
    @results = @m.result.includes(:area, :elevation, :climb_time)
    set_column
  end

  def show
    @mountain = Mountain.find(params[:id])
  end

  private

  def set_column
    @area = Area.all
    @elevation = Elevation.all
    @climb_time = ClimbTime.all
  end
end
