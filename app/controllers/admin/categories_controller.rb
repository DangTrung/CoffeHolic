class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:edit, :update, :destroy]
  before_action :load_parent
  load_and_authorize_resource
  before_action :load_permissions

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category's created"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = "Fails"
      @selected = params[:category][:parent_id]
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    @selected = @category.parent_id
  end

  def update
    if @category.update(category_params)
      flash[:success] = "updated"
      redirect_to admin_categories_path\
    else
      render :new
    end
  end
  
  def destroy
  	@category.destroy
  	redirect_to request.referer
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def load_parent
    @parent = Category.where.not(id: @category&.children&.ids, id: params[:id]) || Category.all
  end

  def category_params
    params.require(:category).permit(:name, :slug, :parent_id)
  end
end
