class SessionsController < ApplicationController
	before_action :load_user, only: [:create]

	def new; end

	def create 
		if @user.authenticate(params[:session][:password])
			log_in @user
			params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
			@user.admin?? (redirect_to admin_root_path):(redirect_back_or root_url)
		else
			flash.now[:danger] = "Wrong password"
			render :new
		end
	end

	def destroy
		log_out
		redirect_to root_path
	end

	private

	def load_user
		@user = User.find_by(email: params[:session][:email].downcase)

		return if @user 

		flash.now[:danger] = "email dosen't exist"
		render :new
	end
end
