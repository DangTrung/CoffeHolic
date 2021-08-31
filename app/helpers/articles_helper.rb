module ArticlesHelper
	def article_categories
		Category.joins(:articles)
	end
end
