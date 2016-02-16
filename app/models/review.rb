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
	validates :post_id, uniqueness: { scope: :user_id, message: "You've already reviewed this post!" }

end
