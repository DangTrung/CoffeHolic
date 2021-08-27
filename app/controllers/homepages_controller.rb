class HomepagesController < ApplicationController
  
  def index; end

  def contact; end

  def about; end

  def category
    if params[:slug] == "product"
      @category = Category.joins(:products)
      @name = "Catgory's Products"
    elsif params[:slug] = "article"
      @category = Category.joins(:articles)
      @name = "Catgory's News"
    else
      redirect_to root_path
    end
  end
end
