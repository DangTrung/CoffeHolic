class SessionsController < ApplicationController
	before_action :load_user, only: [:create, :destroy]

	def new; end

	def create 
		if @user.authenticate(params[:session][:password])
			log_in @user
			redirect_to root_path 
		else
			flash.now[:danger] = "Wrong password"
			render :new
		end
	end

	def destroy
		log_out
	end

	private

	def load_user
		@user = User.find_by(email: params[:session][:email].downcase)

		return if @user 

		flash.now[:danger] = "email dosen't exist"
		render :new
	end
end
