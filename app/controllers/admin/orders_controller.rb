class Admin::OrdersController < Admin::BaseController
  def index
    @order = Order.all
  end

  def show
    @order = Order.includes(:user).find(params[:id])
  end
end
