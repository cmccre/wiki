class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]
	before_action :find_top_tags, only: [:index]

	# From Devise
	before_action :authenticate_user!, except: [:index, :show]

	before_action :authorize_admin, only: [:destroy]

	def index
		
		@articles = Article.where('is_current_article = ?', true)
		if params[:tag]
			@articles = @articles.tagged_with(params[:tag])
		end
		if params[:month] && params[:month] != "Month"
			@articles = @articles.by_month(params[:month])
		end
		if params[:year] && params[:year] != "Year"
			@articles = @articles.by_year(params[:year])
		end
		if params[:query] && params[:query] != ""
	    	@articles = @articles.where('title LIKE ?', "%#{params[:query]}%")
	    end
	    if params[:tag_query] && params[:tag_query] != ""
	    	@articles = @articles.tagged_with(params[:tag_query], :wild => true, :any =>true)
	    end
	    
  		@articles = @articles.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
	end

	def new
		@article = current_user.articles.build
	end

	def create
		if Article.exists?(['title LIKE ?', "%#{params[:article][:title]}%"])
			redirect_to new_article_path, alert: "May Not Create Article with Duplicate Title"
		else
			@article = current_user.articles.build(article_params)
			@article.is_current_article = true
			if @article.save
				redirect_to @article
			else
				redirect_to new_article_path
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
			redirect_to edit_article_path
		end
	end

	def destroy
		if @article.is_current_article
			@new_cur_article = Article.where('title = ? AND is_current_article = ?', @article.title, false).order('created_at DESC').first()
			
			if @new_cur_article
				@new_cur_article.is_current_article = true
				unless @new_cur_article.save
					redirect_to @article, alert: "Error in Deleting Article Revision"
				end
				@article.destroy
				redirect_to @new_cur_article
			else
				@article.destroy
				redirect_to root_path
			end
		else
			@cur_article = Article.where('title = ? AND is_current_article = ?', @article.title, true).first()
			@article.destroy
			redirect_to @cur_article
		end
		
	end

	def show
		@user = User.find(@article.user_id)
		if @article.is_current_article
			@prev_revisions = Article.where('title = ? AND is_current_article = ?', @article.title, false).order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
		end
	end

	private

	def find_top_tags
		@tags = ActsAsTaggableOn::Tag.where.not('name LIKE ?', '% %').most_used(10)
	end

	def article_params
		params.require(:article).permit(:title, :content, :tag_list)
	end

	def find_article
		@article = Article.find(params[:id])
	end
end
