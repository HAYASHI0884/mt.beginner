class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user, :room).order(id: 'DESC')
    @user = @room.users
    redirect_to pages_top_path unless @user.include?(current_user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end
end
