class CommentsController < ApplicationController
	before_action :load_product, :log_in_users
	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = "Commented"
			redirect_to request.referer
		else
			flash[:danger] = "Fails"
			redirect_to request.referer
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:product_id, :content, :user_id)
	end

	def load_product
		Product.find(params[:comment][:product_id])
	end

	def redirect_back_or default
	    redirect_to( session[:forwarding_url] || default)
	    session.delete(:forwarding_url)
  	end

  	def store_location
    	session[:forwarding_url] = product_path(load_product.id)
  	end

  	def log_in_users
	    unless log_in?
	    	store_location
	      	flash[:danger] = "Please log in first"
	     	redirect_to login_url
	    end
  	end
end
