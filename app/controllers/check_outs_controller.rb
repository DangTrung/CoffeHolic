class CheckOutsController < ApplicationController
  before_action :log_in_users, :load_order

  def index
    @order_products = @order.order_products.includes(:product)
  end

  def update
    byebug
  end

  private 

  def load_order
    @order = session[:order_id].nil? ? Order.new : Order.find(session[:order_id])
    return if @order

    flash[:danger] = "Your Cart is empty !"
    redirect_to cart_details_path
  end

  def order_params
    params.require(:order).permit(:address, :phone, :description)
end
