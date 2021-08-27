module Admin::ProductsHelper
	def product_columns
		Product.column_names
	end
end
