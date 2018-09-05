require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
	include Devise::Test::ControllerHelpers
	
	test "should get index" do
	  	get :index
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	end

	test "should get new article page" do
		user = create(:user)
		sign_in user
	  	get :new
	  	assert_response :success
	  	assert_equal "new", @controller.action_name
	end

	test "should get article show page" do
		article = create(:article, :current_article)
	  	get :show, params: { id: article.id }
	  	assert_response :success
	  	assert_equal "show", @controller.action_name
	end

	test "should create article" do
		user = create(:user)
		sign_in user
  		assert_difference('Article.count') do
      		post :create, params: { article: { title: 'a title', content: 'some content.'} }
    	end
    	assert_equal "create", @controller.action_name
	  	assert_redirected_to article_path(id: 1)
	end

	test "should get article edit page" do
		user = create(:user)
		sign_in user
		article = create(:article, :current_article)
	  	get :edit, params: { id: article.id }
	  	assert_response :success
	  	assert_equal "edit", @controller.action_name
	end

	test "should update article" do
		user = create(:user)
		sign_in user
		article = create(:article, :current_article)
	  	put :update, params: { id: article.id, article: { title: article.title, content: 'abcdefghi...' } }
	  	assert_equal "update", @controller.action_name
	  	assert_redirected_to article_path(article.id+1)
	end

	test "should delete only version of article" do
		user = create(:user, :admin)
		sign_in user
		article = create(:article, :current_article)
	  	post :destroy, params: { id: article.id }
	  	assert_equal "destroy", @controller.action_name
	  	assert_redirected_to root_path
	end

	# test "should delete current version of article" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	# 	article1 = create(:article, :some_title)
	# 	article2 = create(:article, :some_title, :current_article)
	#   	post :destroy, params: { id: article2.id }
	#   	assert_response :success
	#   	assert_equal "destroy", @controller.action_name
	#   	assert_redirected_to article_path(article1.id)
	# end

	# test "should delete previous version of article" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	# 	article1 = create(:article, :some_title)
	# 	article2 = create(:article, :some_title, :current_article)
	#   	post :destroy, params: { id: article1.id }
	#   	assert_response :success
	#   	assert_equal "destroy", @controller.action_name
	#   	assert_redirected_to article_path(article2.id)
	# end

	# test "should get article reports index with no reports, no articles" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	#   	get :article_reports
	#   	assert_response :success
	#   	assert_equal "article_reports", @controller.action_name
	#   	assert_equal '@articles.count', 0
	# end

	# test "should get article reports index with no reports, one article" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	# 	create(:article, :current_article)
	#   	get :article_reports
	#   	assert_response :success
	#   	assert_equal "article_reports", @controller.action_name
	#   	assert_equal '@articles.count', 0
	# end

	# test "should get article reports index with one report, one article" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	# 	create(:article, :current_article, :reported)
	#   	get :article_reports
	#   	assert_response :success
	#   	assert_equal "article_reports", @controller.action_name
	#   	assert_equal '@articles.count', 1
	# end

	# test "should report article" do
	# 	user = create(:user)
	# 	sign_in user
	# 	article = create(:article, :current_article)
	# 	assert_equal article.request_approval, false
	#   	post :report, params: { article.id }
	#   	assert_response :success
	#   	assert_equal "report", @controller.action_name
	#   	assert_equal article.request_approval, true
	#   	assert_redirected_to article_path(article.id)
	# end

	# test "should approve article" do
	# 	user = create(:user, :admin)
	# 	sign_in user
	# 	article = create(:article, :current_article, :reported)
	# 	assert_equal article.request_approval, true
	#   	post :approve, params: { article.id }
	#   	assert_response :success
	#   	assert_equal "approve", @controller.action_name
	#   	assert_equal article.request_approval, false
	#   	assert_equal article.approved, true
	#   	assert_redirected_to article_path(article.id)
	# end

	# test "should search for article with existing tag" do
	#   create(:article, :current_article, :geology)	
	#   post :index, params: { tag: 'geology' }
	#   assert_equal '@articles.count', 1
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing tag but not current" do
	#   create(:article, :geology)	
	#   post :index, params: { tag: 'geology' }
	#   assert_equal '@articles.count', 0
	#   assert_redirected_to root_path
	# end

	# test "should search for article with nonexisting tag" do
	#   create(:article, :current_article, :geology)
	#   post :index, params: { tag: 'abcde' }
	#   assert_equal '@articles.count', 0
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing title" do
	#   create(:article, :some_title, :current_article)
	#   assert_equal('@articles.count', 1) do
	#     post :index, params: { query: 'SOME TITLE' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing title but not current" do
	#   create(:article, :some_title)
	#   assert_equal('@articles.count', 0) do
	#     post :index, params: { query: 'SOME TITLE' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with nonexisting title" do
	#   create(:article, :some_title, :current_article)
	#   assert_equal('@articles.count', 0) do
	#     post :index, params: { query: 'abcde' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing title and tag" do
	#   create(:article, :some_title, :current_article, :geology)
	#   assert_equal('@articles.count', 1) do
	#     post :index, params: { query: 'SOME TITLE', tag: 'geology' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing title and tag but not current" do
	#   create(:article, :some_title, :geology)
	#   assert_equal('@articles.count', 0) do
	#     post :index, params: { query: 'SOME TITLE', tag: 'geology' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with nonexisting title but existing tag" do
	#   create(:article, :some_title, :current_article, :geology)
	#   assert_equal('@articles.count', 0) do
	#     post :index, params: { query: 'abcde', tag: 'geology' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with existing title but nonexisting tag" do
	#   create(:article, :some_title, :current_article, :geology)
	#   assert_equal('@articles.count', 0) do
	#     post :index, params: { query: 'SOME TITLE', tag: 'abcde' }
	#   end
	#   assert_redirected_to root_path
	# end

	# test "should search for article with nonexisting title and tag" do
	#   create(:article, :some_title, :current_article, :geology)
	#   assert_equal('@articles.count', 1) do
	#     post :index, params: { query: 'abcde', tag: 'fghij' }
	#   end
	#   assert_redirected_to root_path
	# end
end
