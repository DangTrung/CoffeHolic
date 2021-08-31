class CategoriesController < ApplicationController
  def index
     if params[:slug] == "product"
      @category = Category.joins(:products).distinct
      @product = @category.map{|i| i.products&.first}.uniq
    elsif params[:slug] = "article"
      @category = Category.joins(:articles).distinct
      @article = @category.map{|i| i.articles&.first}.uniq
    else
      redirect_to root_path
    end
  end

  def show
    @category = Category.find(params[:id])
    @product = @category.products
    @article = @category.articles
  end
end
