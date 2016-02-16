class Post < ActiveRecord::Base
	# this is right
	belongs_to :user
	validates :user_id, presence: true
	validates :title, presence: true
	has_many :reviews	
 	validates_uniqueness_of :title	
	
	has_many :buyers
        has_many :users, through: :buyers

 	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

        # has_many(:buyers, :foreign_key => :buyer_a_id, :dependent => :destroy)
        # has_many(:reverse_buyers, :class_name => :Buyer, :foreign_key => :buyer_b_id, :dependent => :destroy)
        # has_many :users, :through => :buyers :source => :buyer_b
end
