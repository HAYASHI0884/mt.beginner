class RoomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.present?
      if @room.save
        redirect_to pages_top_path
      else
        render :new
      end
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to pages_top_path
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: []).merge(user_id: current_user.id)
  end
end
