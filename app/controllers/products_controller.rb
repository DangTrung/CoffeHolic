class ProductsController < ApplicationController
  def index
    @product = Product.all
  end

  def show
    @product = Product.includes(:comments).find(params[:id])
  end
end