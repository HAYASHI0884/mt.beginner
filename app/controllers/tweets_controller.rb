class TweetsController < ApplicationController
  before_action :set_tweet, only:[:show, :edit, :update, :destroy]

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to pages_top_path
    else
      render :new
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id)
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:title, :introduction, :image).merge(user_id: current_user.id)
    end
end
