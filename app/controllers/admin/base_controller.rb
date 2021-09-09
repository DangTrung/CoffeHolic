class Admin::BaseController < ApplicationController
	before_action :is_logged_and_admin?
	layout 'admin/admin'

	private

	def is_logged_and_admin?
		unless log_in?
	    	store_location
	      	flash[:danger] = "Please log in first"
	     	redirect_to login_path
		else 
			is_admin?
		end
	end

  	def is_admin?
  		unless current_user&.admin?
			flash[:danger] = "Your aren't admin"
			redirect_to root_path
		end
	end
end