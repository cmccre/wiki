class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]

	# From Devise
	before_action :authenticate_user!, except: [:index, :show]

	before_action :authorize_admin!, only: [:destroy]

	def index
  		@articles = Article.searchCurrent(params[:query])
	end

	def new
		@article = current_user.articles.build
	end

	def create
		if Article.exists?(['title LIKE ?', "%#{params[:title]}%"])
			flash.alert = "May Not Create Article with Duplicate Title"
			render 'new'
		else
			@article = current_user.articles.build(article_params)
			@article.is_current_article = true
			if @article.save
				redirect_to @article
			else
				render 'new'
			end
		end
	end

	def edit
	end

	def update
		@article.is_current_article = false
		@article_revision = current_user.articles.build(article_params)
		@article_revision.is_current_article = true

		if @article.save && @article_revision.save
			redirect_to @article_revision
		else
			render 'edit'
		end
	end

	def destroy
		if @article.is_current_article
			@new_cur_article = Article.where('title = ? AND is_current_article = ?', @article.title, false).order('created_at DESC').first()
			@new_cur_article.is_current_article = true
			unless @new_cur_article.save
				flash.alert = "Error in Deleting Article Revision"
				render 'show'
			end 
		end
		@article.destroy
		redirect_to @new_cur_article
	end

	def show
		@user = User.find(@article.user_id)
	end

	private

	def article_params
		params.require(:article).permit(:title, :content)
	end

	def find_article
		@article = Article.find(params[:id])
	end
end
