module Admin::OrdersHelper

	def order_columns
		order = Order.columns.map(&:name)
		order.delete("user_id")
		#Order.column_names =|> tra ve frozenarray ko thay doi dc gia tri
		order
	end
end
