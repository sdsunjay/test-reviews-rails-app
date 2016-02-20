class Post < ActiveRecord::Base
	# You know, for search
	searchkick
        
	delegate :email, to: :user, prefix: true
	belongs_to :user
	validates :user_id, presence: true
	validates :title, presence: true
	has_many :reviews
	validates_uniqueness_of :title

	has_many :buyers
	has_many :users, through: :buyers


	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	enum status: {
	    # The ride has not left yet
	    open: 0,
	    # More than 0 riders and the ride is NOT over
	    pending: 1,
	    # More than 0 riders and the ride is over
	    complete: 2,
	    # No riders and the ride is over
	    incomplete: 3
	}

	def check_start_date
		if self.when < DateTime.now && buyers.any?
			# More than 0 riders and the ride is over
			self.status = 'complete'
			self.save
		elsif self.when < DateTime.now 
			# No riders and the ride is over
			self.status = 'incomplete'
			self.save
		end
        end

	# has_many(:buyers, :foreign_key => :buyer_a_id, :dependent => :destroy)
	# has_many(:reverse_buyers, :class_name => :Buyer, :foreign_key => :buyer_b_id, :dependent => :destroy)
	# has_many :users, :through => :buyers :source => :buyer_b
	end
