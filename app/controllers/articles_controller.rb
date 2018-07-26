class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]

	# From Devise
	before_action :authenticate_user!, except: [:index, :show]

	def index
  		@articles = Article.search(params[:query])
	end

	def new
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to root_path
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

	def self.search(query)
	  if query
	    where('title LIKE ?', "%#{query}%").order('created_at DESC')
	  else
	    order('created_at DESC') 
	  end
	end

end
