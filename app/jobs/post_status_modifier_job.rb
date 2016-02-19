class PostStatusModifierJob < ActiveJob::Base
  queue_as :default
  RUN_EVERY = 1.hour
  # self.class.set(wait: RUN_EVER).perform_later
  def perform(*args)
      # Get all posts in database where status is either 'pending' or 'open'
      @posts = Post.where(status: ['open', 'pending'])
      # See if date (when column in Post table) is in the past
      for post in @posts
          post.check_start_date
	  # if yes and was status was 'pending', then updated status to 'completed'
	  # if yes and status was 'open', then update status to 'incomplete'
	  post.save!
       end
  end
end
