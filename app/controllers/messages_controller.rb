class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:index, :create]

  def index
    @message = Message.new
    if @room.presents?
      @messages = @room.messages.includes(:user, :room).order(id: 'DESC')
      @user = @room.users
      redirect_to pages_top_path unless @user.include?(current_user)
    end
  end

  def create
    if @room.presents?
      @message = @room.messages.new(message_params)
      if @message.save
        redirect_to room_messages_path(@room)
      else
        @messages = @room.messages.includes(:user)
        render :index
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end
end
