module Admin::RolesHelper
	def role_names
		@name = Permission.pluck(:subject_class).uniq
	end

	def role_columns
		Role.columns.map(&:name)
	end

	def role_permissions role
		h = Hash.new
		subject_class = role.permissions.pluck(:subject_class).uniq
		subject_class.each do |role_name|
			action = []
		  	role.permissions.each do |a|
		    	if a.subject_class = role_name
		        	action << a.action
		    	end
		   	end
			h[role_name] = action
		end
		h
	end
end
