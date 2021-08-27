class Article < ApplicationRecord

	has_many :category_objects, as: :objectable
	has_many :categories, through: :category_objects
	has_many_attached :images
end
