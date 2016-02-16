class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
        has_many :reviews
	has_many :buyers
        has_many :posts, through: :buyers, dependent: :destroy
end

