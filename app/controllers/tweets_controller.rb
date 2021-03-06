class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :if_not_admin, only: [:index]

  def index
    @tweets = Tweet.includes(:user).order(id: 'DESC')
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
    redirect_to pages_top_path unless current_user.id == @tweet.user.id || current_user.admin == true
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.present?
      if @tweet.save
        redirect_to pages_top_path
      else
        render :new
      end
    end
  end

  def update
    if @tweet.present?
      if @tweet.update(tweet_params)
        redirect_to tweet_path(@tweet.id)
      else
        render :edit
      end
    end
  end

  def destroy
    if @tweet.present?
      @tweet.destroy
      redirect_to pages_top_path
    end
  end

  private

  def if_not_admin
    redirect_to pages_top_path unless current_user.admin?
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:title, :introduction, :image).merge(user_id: current_user.id)
  end
end
