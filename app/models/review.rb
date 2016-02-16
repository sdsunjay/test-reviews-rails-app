class Review < ActiveRecord::Base

	validates :reviewee_id, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true
	validates :title, presence: true
	validates :rating, presence: true
	validates :description, presence: true
	belongs_to :user
        belongs_to :post
 	validates_uniqueness_of :title
	# post will have many reviews

end
