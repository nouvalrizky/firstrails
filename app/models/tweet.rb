class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  def published?
    tweet_id?
  end

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def publish_to_twitter!
    # Make post request to Twitter API for publish the tweet, and then store the response to tweet object
    tweet = twitter_account.client.update(body)

    # Update the tweet id field in the record to tweet id we get in response
    update(tweet_id: tweet.id)
  end
  
end
