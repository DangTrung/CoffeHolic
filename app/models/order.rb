class Order < ApplicationRecord
	before_update :load_user

	belongs_to :user, optional: true
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products

	validates :address, presence: true, allow_nil: true

	private

	def load_user
		self[:user_id] = current_user.id
	end

	def current_user
		@current_user ||= User.find(session[:user_id])
	end

end
