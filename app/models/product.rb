class Product < ApplicationRecord

	has_many :category_objects, as: :objectable
	has_many :categories, through: :category_objects
	has_many :order_products
	has_many :comments
	has_one_attached :image
	
	validates :price, presence: true, numericality: { only_integer: true, greater_than: 0}
	validates :name, presence: true, uniqueness: true
end
