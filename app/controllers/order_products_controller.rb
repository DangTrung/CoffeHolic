class OrderProductsController < ApplicationController
	before_action :current_order, only: [:create, :quick_add, :destroy]

	def create
		if @order.order_products.find_by(product_id: params[:order_product][:product_id]).blank?
			@order_product = @order.order_products.new(order_product_params)
	        @order.save
	        session[:order_id] = @order.id
	        flash[:success] = "Added to your cart"
	        redirect_to request.referer || root_path
	    else #san pham da order
	    	update_quantity_product
	    	redirect_to request.referer || root_path
	    end
	end

	def quick_add
		if @order.order_products.find_by(product_id: params[:product_id]).blank?
			@order_product = @order.order_products.new(product_id: params[:product_id], quantity: 1)
	        @order.save
	        session[:order_id] = @order.id
	        flash[:success] = "Added to your cart"
	        redirect_to request.referer || root_path
	    else 
	    	add_a_quantity
	    	redirect_to request.referer || root_path
	    end
	end

	def show
		@order_products = current_order.order_products
	end

	def destroy # delete a product
		@order_product = OrderProduct.find_by(product_id: params[:id])
		@order_product.destroy
		redirect_to request.referer || root_path
	end

	private

	def add_a_quantity
		@order_product = @order.order_products.find_by(product_id: params[:product_id])
		@order_product.quantity += 1
		@order_product.save
	end

	def update_quantity_product
		@order_product = @order.order_products.find_by(product_id: params[:order_product][:product_id])
		@order_product.update(quantity: params[:order_product][:quantity])
	end
	
	def order_product_params
		params.require(:order_product).permit(:quantity, :product_id)
	end

	def current_order
	    @order = session[:order_id].nil? ? Order.new : Order.find(session[:order_id])
    end
end
