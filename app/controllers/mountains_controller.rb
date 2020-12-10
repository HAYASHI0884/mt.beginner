class MountainsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_admin, only: [:edit]

  def index
    @m = Mountain.ransack(params[:q])
    @results = @m.result.includes(:area, :elevation, :climb_time)
    set_column
  end

  def show
    @mountain = Mountain.find(params[:id])
  end

  def edit
  end


  private

  def set_column
    @area = Area.all
    @elevation = Elevation.all
    @climb_time = ClimbTime.all
  end

  def user_admin
    @users = User.all
    if current_user.admin == false
        redirect_to pages_top_path
    else
        render action: "edit"
    end
 end
end
