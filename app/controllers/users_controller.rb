class UsersController < ApplicationController

	# From Devise
	before_action :authenticate_user!

	before_action :authorize_admin

	def index
  		@users = User.all.order(:email).paginate(:page => params[:page], :per_page => 5)
	end

	def show
		@user = User.find(params[:id])
		@articles = Article.where('user_id = ?', params[:id]).order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
	end

	def toggle_is_active
		@user = User.find(params[:id])
		if @user.is_active
			@user.is_active = false
		else
			@user.is_active = true
		end
		@user.save
		redirect_to users_path
	end
end