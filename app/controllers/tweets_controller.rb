class TweetsController < ApplicationController
    before_action :require_user_logged_in!

    def index
        @tweets = Current.user.tweets
        @published_tweets = Current.user.tweets.where.not(tweet_id: nil)
        @unpublished_tweets = Current.user.tweets.where(tweet_id: nil)
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet was scheduled successfully"
        else
            render :new
        end
    end

    private

    def tweet_params
        Rails.logger.info params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end
end