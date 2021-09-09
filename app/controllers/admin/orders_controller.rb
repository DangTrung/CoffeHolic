class Admin::OrdersController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_permissions
  
  def index
    @order = Order.where.not(customer_name: nil)
  end

  def show
    @order = Order.includes(:user).find(params[:id])
  end
end
