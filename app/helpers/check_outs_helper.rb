module CheckOutsHelper
	def order_product
		@order.order_products.includes(:product)
	end

	def value_ordeded
		current_user&.orders.last
	end
end
