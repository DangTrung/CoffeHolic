class CheckOutsController < ApplicationController
  before_action :log_in_users, :load_order 

  def index
  end

  def update
    if @order.update(order_params)
      flash = "Your are checked"
      redirect_to root_path
    else
      render :index
    end
  end

  private 

  def load_order
    @order = session[:order_id].nil? ? Order.new : Order.find(session[:order_id])
    return if @order

    flash[:danger] = "Your Cart is empty !"
    redirect_to cart_details_path
  end

  def order_params
    params.require(:orders).permit(:address, :phone, :description, :user_id, :customer_name)
  end
end
