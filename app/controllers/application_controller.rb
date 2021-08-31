class ApplicationController < ActionController::Base
	include SessionsHelper
	 
	protected
	 
	def self.permission
	    return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
	end
	 
  	def current_ability
    	@current_ability ||= Ability.new(current_user)
  	end
	 
  	def load_permissions
    	@current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
  	end
end
	