class PostStatusModifierJob < ActiveJob::Base
  queue_as :default
   # RUN_EVERY = 1.hour
  # self.class.set(wait: RUN_EVER).perform_later
  def perform(*args)
      # Get all posts in database where status is either 'open' or 'pending'
      # TODO Use constants instead of 'magic numbers'
      @posts = Post.where(status: [0, 1])
      # See if date (when column in Post table) is in the past
      for post in @posts
	  # if yes and was status was 'pending', then updated status to 'completed'
	  # if yes and status was 'open', then update status to 'incomplete'
          post.check_start_date
       end
  end
end
