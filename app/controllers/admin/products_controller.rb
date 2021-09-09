class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: [:show, :edit, :update, :destroy]
  before_action :load_category, only: [:edit, :new]
  load_and_authorize_resource
  before_action :load_permissions

  def index
    @product = Product.includes(:categories).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(:product_params)

    if @product.save
      flash = "product was created"
      redirect_to admin_products_path
    else
      render :new
    end

  end

  def show
  end

  def edit
    @selected = @product.category_ids
  end

  def update
    if @product.update(product_params)
      @product.category_ids = params[:product][:category_ids]
      flash[:success] = "The product was updated"
      redirect_to admin_products_path
    else
      @selected = params[:product][:category_ids]
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to request.referer
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :image)
  end

  def load_category
    @category = Category.all
  end
end
