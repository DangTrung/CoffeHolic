module Admin::CategoriesHelper
	def category_colunms
		Category.column_names
	end
end
