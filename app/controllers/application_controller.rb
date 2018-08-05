class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  	def configure_permitted_parameters
    	update_attrs = [:password, :password_confirmation, :current_password]
    	devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  	end


	def authorize_admin
    	redirect_to root_path, alert: 'Access Denied' unless current_user.is_admin
  	end
end
