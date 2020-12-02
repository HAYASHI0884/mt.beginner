class PagesController < ApplicationController
  def index
  end

  def top
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to pages_top_path unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
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
end
