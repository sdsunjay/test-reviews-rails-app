class Buyer < ActiveRecord::Base
  delegate :email, to: :user, prefix: true
  belongs_to :post
  belongs_to :user
  validates :post_id, uniqueness: { scope: :user_id, message: "You've already expressed interest in this post!" }
end
