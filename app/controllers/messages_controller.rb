class MessagesController < ApplicationController

	def create
		unless load_user.present?
			@user = User.create!(email: params[:message][:email].downcase, name: params[:message][:name])
			Message.create(content: params[:message][:content], user_id: @user.id)
			flash[:success] = "Message Sent. Thank You So Much!"
			redirect_to request.referer
		else
			Message.create(content: params[:message][:content], user_id: @user.id)
			flash[:success] = "Message Sent. Thank You So Much!"
			redirect_to request.referer
		end
	end

	private

	def load_user
		@user = current_user || User.find_by(email: params[:message][:email].downcase)
	end
end
