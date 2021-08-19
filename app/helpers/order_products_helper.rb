module OrderProductsHelper

	def price order_products
		order_products.quantity*order_products.unit_price
	end
	
	def total_price
		@order_products.map{|i| i.unit_price*i.quantity}.sum 
	end
end
