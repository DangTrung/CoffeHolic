class Category < ApplicationRecord
	before_save :format_slug
	
	has_many :category_objects, dependent: :destroy
	has_many :products, through: :category_objects, source: :objectable, source_type: "Product" 
	has_many :articles, through: :category_objects, source: :objectable, source_type: "Article"
	validates :name, presence: true
	has_many :children, class_name: "Category", foreign_key: "parent_id"
	belongs_to :parent, class_name: "Category", optional: true

	private

	def format_slug
		self.slug = name.parameterize
	end
end
