module CheckOutsHelper
	def order_product
		@order.order_products.includes(:product)
	end
end
