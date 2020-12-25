class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :explain]
  before_action :set_user, only: [:show, :edit, :update]

  def index
  end

  def top
    @tweets = Tweet.includes(:user).order(id: 'DESC')
    @rooms = Room.includes(:messages, :entries, :users, :user).order(id: 'DESC')
  end

  def explain
  end

  def show
  end

  def edit
    redirect_to pages_top_path unless current_user.id == @user.id
  end

  def update
    if @user.update(user_params)
      redirect_to page_path(current_user.id)
    else
      render edit_page_path(current_user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:text, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
