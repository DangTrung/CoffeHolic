module Admin::UsersHelper
	def user_columns
		User.column_names
	end
end
