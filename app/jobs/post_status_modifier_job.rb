class PostStatusModifierJob < ActiveJob::Base
  queue_as :default
  RUN_EVERY = 1.day
  # Get date (when column in Post table) for all posts in database where status is either 'pending' or 'open'
  # See if that datetime is in the past
	  # if yes and was status was 'pending', then updated status to 'completed'
	  # if yes and status was 'open', then update status to 'incomplete'
  # if not, do nothing
  def perform(*args)
    self.class.perform_later(wait: RUN_EVERY)
  end
end
