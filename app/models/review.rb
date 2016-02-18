class Review < ActiveRecord::Base

	belongs_to :user
	belongs_to :post
	# post will have many reviews

	validates :reviewee_id, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true
	validates :title, presence: true
	validates :rating, presence: true
	validates :description, presence: true
	validates_uniqueness_of :title
	# the driver (owner of the post) can review multiple passengers, but not more than once for the same post
	validates :post_id, uniqueness: { scope: [:user_id, :reviewee_id], message: "You've already reviewed this post!" }
	def self.reviewer_is_driver?(current_user_id, post_id_user)
		current_user_id == post_id_user
	end
end
