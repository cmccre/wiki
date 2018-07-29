class UsersController < ApplicationController

	# From Devise
	before_action :authenticate_user!

	before_action :authorize_admin

	def index
  		@users = User.all.order(:email)
	end

	def toggle_is_active
		@user = User.find(params[:id])
		if @user.is_active
			@user.is_active = false
		else
			@user.is_active = true
		end
		@user.save
	end
end