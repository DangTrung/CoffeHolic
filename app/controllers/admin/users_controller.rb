class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

  def index
    @user = User.all 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User's created"
      redirect_to admin_users_path
    else 
      flash.now[:danger] = "User's not created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User's updated"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "User's not updated"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "The User's deleted"
    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
