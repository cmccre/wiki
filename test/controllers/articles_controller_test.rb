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

	test "should not create article with same title" do
		user = create(:user)
		sign_in user
  		assert_difference('Article.count') do
      		post :create, params: { article: { title: 'a title', content: 'some content.'} }
    	end
    	assert_no_difference('Article.count') do
      		post :create, params: { article: { title: 'a title', content: 'some other content.'} }
    	end
    	assert_equal "create", @controller.action_name
    	assert_equal "May Not Create Article with Duplicate Title", flash[:alert]
	  	assert_redirected_to new_article_path
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

	test "should delete current version of article" do
		user = create(:user, :admin)
		sign_in user
		article1 = create(:article, :some_title)
		article2 = create(:article, :some_title, :current_article)
	  	post :destroy, params: { id: article2.id }
	  	assert_equal "destroy", @controller.action_name
	  	assert_redirected_to article_path(article1.id)
	end

	test "should delete previous version of article" do
		user = create(:user, :admin)
		sign_in user
		article1 = create(:article, :some_title)
		article2 = create(:article, :some_title, :current_article)
	  	post :destroy, params: { id: article1.id }
	  	assert_equal "destroy", @controller.action_name
	  	assert_redirected_to article_path(article2.id)
	end

	test "should get article reports index with no reports, no articles" do
		user = create(:user, :admin)
		sign_in user
	  	get :article_reports
	  	assert_equal assigns[:articles].size, 0
	  	assert_response :success
	  	assert_equal "article_reports", @controller.action_name
	end

	test "should get article reports index with no reports, one article" do
		user = create(:user, :admin)
		sign_in user
		create(:article, :current_article)
	  	get :article_reports
	  	assert_equal assigns[:articles].size, 0
	  	assert_response :success
	  	assert_equal "article_reports", @controller.action_name
	end

	test "should get article reports index with one report, one article" do
		user = create(:user, :admin)
		sign_in user
		create(:article, :current_article, :reported)
	  	get :article_reports
	  	assert_equal assigns[:articles].size, 1
	  	assert_response :success
	  	assert_equal "article_reports", @controller.action_name
	end

	test "should report article" do
		user = create(:user)
		sign_in user
		article = create(:article, :current_article)
		assert_equal article.request_approval, false
	  	post :report, params: { id: article.id }
	  	assert_equal "report", @controller.action_name
	  	assert_equal assigns[:article].request_approval, true
	  	assert_redirected_to article_path(article.id)
	end

	test "should approve article" do
		user = create(:user, :admin)
		sign_in user
		article = create(:article, :current_article, :reported)
		assert_equal article.request_approval, true
	  	post :approve, params: { id: article.id }
	  	assert_equal "approve", @controller.action_name
	  	assert_equal assigns[:article].request_approval, false
	  	assert_equal assigns[:article].approved, true
	  	assert_redirected_to article_path(article.id)
	end

	test "should search for article with existing tag" do
	  create(:article, :current_article, :geology)	
	  post :index, params: { tag: 'geology' }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing tag but not current" do
	  create(:article, :geology)	
	  post :index, params: { tag: 'geology' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting tag" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'abcde' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'SOME TITLE' }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing title but not current" do
	  create(:article, :some_title)
	  post :index, params: { query: 'SOME TITLE' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'abcde' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and tag" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology' }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing title and tag but not current" do
	  create(:article, :some_title, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title but existing tag" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'geology' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title but nonexisting tag" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'abcde' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and tag" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'fghij' }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article published this month and year" do
		create(:article, :current_article)
		post :index, params: { month: Date.today.month, year: Date.today.year }
		assert_equal assigns[:articles].count, 1
	  	assert_response :success
	end

	test "should search for article published this month and year but not current" do
		create(:article)
		post :index, params: { month: Date.today.month, year: Date.today.year }
		assert_equal assigns[:articles].count, 0
	  	assert_response :success
	end

	test "should search for article published this month" do
		create(:article, :current_article)
		post :index, params: { month: Date.today.month }
		assert_equal assigns[:articles].count, 1
	  	assert_response :success
	end

	test "should search for article published this year" do
		create(:article, :current_article)
		post :index, params: { year: Date.today.year }
		assert_equal assigns[:articles].count, 1
	  	assert_response :success
	end

	test "should search for article published another month and this year" do
		create(:article, :current_article)
		post :index, params: { month: Date.today.month-1, year: Date.today.year }
		assert_equal assigns[:articles].count, 0
	  	assert_response :success
	end

	test "should search for article published this month and another year" do
		create(:article, :current_article)
		post :index, params: { month: Date.today.month, year: 2000 }
		assert_equal assigns[:articles].count, 0
	  	assert_response :success
	end

	test "should search for article published another month and another year" do
		create(:article, :current_article)
		post :index, params: { month: Date.today.month-1, year: 2000 }
		assert_equal assigns[:articles].count, 0
	  	assert_response :success
	end

	test "should search for article with existing title, published this month and year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'SOME TITLE', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing title, published this month and year, but not current" do
	  create(:article, :some_title)
	  post :index, params: { query: 'SOME TITLE', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title, published this month and year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'abcde', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title, published another month and this year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'SOME TITLE', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title, published this month and another year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'SOME TITLE', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title, published another month and year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'SOME TITLE', month: Date.today.month-1, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title, published another month and year" do
	  create(:article, :some_title, :current_article)
	  post :index, params: { query: 'abcde', month: Date.today.month-1, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing tag, published this month and year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'geology', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing tag, published this month and year, but not current" do
	  create(:article, :geology)
	  post :index, params: { tag: 'geology', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting tag, published this month and year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'abcde', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing tag, published another month and this year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'geology', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing tag, published this month and another year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'geology', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing tag, published another month and year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'geology', month: Date.today.month-1, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting tag, published another month and year" do
	  create(:article, :current_article, :geology)
	  post :index, params: { tag: 'abcde', month: Date.today.month-1, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and tag, published this month and year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 1
	  assert_response :success
	end

	test "should search for article with existing title and tag, published this month and year but not current" do
	  create(:article, :some_title, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title, existing tag, published this month and year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'geology', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title, nonexisting tag, published this month and year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'abcde', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and tag, published this month and year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'fghij', month: Date.today.month, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and tag, published another month and this year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and existing tag, published another month and this year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'geology', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and nonexisting tag, published another month and this year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'abcde', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and tag, published another month and this year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'fghij', month: Date.today.month-1, year: Date.today.year }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and tag, published this month and another year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'geology', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and existing tag, published this month and another year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'geology', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with existing title and nonexisting tag, published this month and another year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'SOME TITLE', tag: 'abcde', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and tag, published this month and another year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'fghij', month: Date.today.month, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

	test "should search for article with nonexisting title and tag, published another month and year" do
	  create(:article, :some_title, :current_article, :geology)
	  post :index, params: { query: 'abcde', tag: 'fghij', month: Date.today.month-1, year: 2000 }
	  assert_equal assigns[:articles].count, 0
	  assert_response :success
	end

end
