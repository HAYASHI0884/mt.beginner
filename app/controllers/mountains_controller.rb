class MountainsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mountain, only: [:show, :edit, :update, :destroy]
  before_action :user_admin, only: [:edit, :new]
  before_action :set_column, only: [:index, :new, :edit, :create]

  def index
    @mountains = Mountain.ransack(params[:q])
    @mountain_results = @mountains.result.includes(:area, :elevation, :climb_time)
  end

  def show
  end

  def new
    @mountain = Mountain.new
  end

  def create
    @mountain = Mountain.new(mountain_params)
    if @mountain.save
      redirect_to mountain_admin_mountains_path(@mountain)
    else
      render action: :new
    end
  end

  def destroy
    @mountain.destroy
    redirect_to mountain_admin_mountains_path(@mountain)
  end

  def edit
  end

  def update
    if @mountain.update(mountain_params)
      redirect_to mountain_admin_mountains_path(@mountain)
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
    redirect_to pages_top_path if current_user.admin == false
  end
end
