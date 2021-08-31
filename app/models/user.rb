class User < ApplicationRecord
	attr_accessor :remember_token, :reset_token
	before_save :downcase_email
	
	has_many :articles
	has_many :orders, foreign_key: 'user_id', dependent: :destroy
	has_one_attached :avatar
	has_many :comments, dependent: :destroy
	belongs_to :role, optional: true

	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  	validates :email, presence: true,
            length: {maximum: 225},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  	has_secure_password
  	validates :password, presence: true,
            length: {minimum: 6},
            allow_nil: true

    class << self
    	def new_token 
    	end
    	def digest string
    		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      		BCrypt::Password.create(string, cost: cost)
    	end
    end

    def authenticated? attribute, token
	    digest = send("#{attribute}_digest")
	    return false if digest.nil?
	    BCrypt::Password.new(digest).is_password?(token)
  	end

	def forgot
	    update_attribute(:remember_digest, nil)
	 end

  	def remember
	    self.remember_token = User.new_token
	    update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def create_reset_digest
	    self.reset_token = User.new_token
	    update_columns(reset_digest: User.digest(reset_token), reset_sent: Time.zone.now)
  	end

  	def send_password_reset_email
    	UserMailer.password_reset(self).deliver_now
  	end

  	def password_reset_expired?
    	reset_sent < 2.hours.ago
  	end

    private

    def downcase_email
    	email.downcase!
    end

end
