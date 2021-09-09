module ProductsHelper
	def load_recommend
		Product.first(3)
	end
end
