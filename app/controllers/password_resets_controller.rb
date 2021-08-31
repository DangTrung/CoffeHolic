class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by( email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "email sent with password_reset"
      redirect_to root_path
    else
      flash.now[:danger] = "Email's not found"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be blank ")
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = "Password Reset "
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def get_user
    @user = User.find params[:id]
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "password_reset_expired"
      redirect_to new_password_reset_path
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
