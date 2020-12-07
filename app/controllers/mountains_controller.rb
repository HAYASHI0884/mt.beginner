class MountainsController < ApplicationController
  def index
    @m = Mountain.ransack(params[:q])
    @results = @m.result
    set_column
  end

  def show
    @mountain = Mountain.find(params[:id])
  end

  private

  def set_column
    @area = Area.select("name").distinct
    @elevation = Elevation.select("name").distinct
    @climb_time = ClimbTime.select("name").distinct
  end
end
