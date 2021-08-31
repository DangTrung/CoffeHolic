module Admin::ArticlesHelper
	def product_columns
		article = Article.columns.map(&:name)
	end
end
