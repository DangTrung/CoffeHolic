class Order < ApplicationRecord
	belongs_to :user, optional: true
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products

	validates :address, presence: true, allow_nil: true
end
