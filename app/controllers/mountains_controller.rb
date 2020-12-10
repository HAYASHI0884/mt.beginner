class MountainsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mountain, only: [:show, :edit, :update, :destroy]
  before_action :user_admin, only: [:edit, :new]
  before_action :set_column, only: [:index, :new, :edit]

  def index
    @m = Mountain.ransack(params[:q])
    @results = @m.result.includes(:area, :elevation, :climb_time)
  end

  def show
  end

  def new
    @mountain = Mountain.new
  end

  def create
    @mountain = Mountain.new(mountain_params)
    if @mountain.save
      redirect_to "/mountains/:mountain_id/admin/mountains"
    else
      render action: :new
    end
  end

  def destroy
    @mountain.destroy
    redirect_to "/mountains/:mountain_id/admin/mountains"
  end

  def edit
  end

  def update
    if @mountain.update(mountain_params)
      redirect_to "/mountains/:mountain_id/admin/mountains"
    else
      render edit_mountain_path(@mountain.id)
    end
  end

  private

  def set_mountain
    @mountain = Mountain.find(params[:id])
  end

  def mountain_params
    params.require(:mountain).permit(:name, :area_id, :elevation_id, :climb_time_id, :image)
  end

  def set_column
    @area = Area.all
    @elevation = Elevation.all
    @climb_time = ClimbTime.all
  end

  def user_admin
    @users = User.all
    if current_user.admin == false
      redirect_to pages_top_path
    end
 end
end
