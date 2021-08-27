class Admin::ArticlesController < Admin::BaseController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :load_category, only: [:new, :edit]
  def index
    @article = Article.includes(:categories).all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      @article.category_ids = params[:article][:category_ids]
      flash[:success] = "The new article was created"
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def show; end

  def edit
    @selected = @article.category_ids
  end

  def update
    if @article.update(article_params)
      @article.category_ids = params[:article][:category_ids]
      flash[:success] = "The Article's Updated"
      redirect_to admin_articles_path
    else
      @selected = params[:article][:category_ids]
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "The article was deleted"
    redirect_to request.referer
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def load_category
    @category = Category.all
  end

  def article_params
    params.require(:article).permit(:title, :slug, :description, :content)
  end
end
