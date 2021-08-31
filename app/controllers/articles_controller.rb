class ArticlesController < ApplicationController
  def index
    @article = Article.includes(:categories).all
  end

  def show
    @article = Article.find(params[:id])
  end
end
