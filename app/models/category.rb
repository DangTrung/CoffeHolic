class Category < ApplicationRecord

	has_many :category_objects, dependent: :destroy
	has_many :products, through: :category_objects, source: :objectable, source_type: "Product" 
	has_many :articles, through: :category_objects, source: :objectable, source_type: "Article"
end
