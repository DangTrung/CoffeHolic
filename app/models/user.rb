class User < ApplicationRecord
	before_save :downcase_email
	
	has_many :articles
	has_many :orders, foreign_key: 'user_id', dependent: :destroy
	has_one_attached :avatar

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

    private

    def downcase_email
    	email.downcase!
    end

end
