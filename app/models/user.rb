class User < ApplicationRecord

	has_many :articles
	has_many :orders, foreign_key: 'user_id', dependent: :destroy

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

end
