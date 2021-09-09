class UsersController < ApplicationController
   before_action :log_in_users, only: [:show, :edit]
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:success] = "Created User"
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = "Fails"
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = "Your profile updated"
      redirect_to root_path
    else
      flash.now[:danger] = "Fails"
      render :new
    end
  end

  def order_history
    @order = current_user.orders
    render "order_history"
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end
end
