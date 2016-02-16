class Buyer < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post_id, uniqueness: { scope: :user_id, message: "You've already expressed interest in this post!" }
end
