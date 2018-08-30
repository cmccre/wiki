require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
	test "should get index"
	  	get articles_path
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	  	get root_path
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	end

	test "should search for article with existing tag" do
	  assert_equal('@articles.count', 1) do
	    post articles_path, params: { tag: 'science' }
	  end
	  assert_redirected_to articles_path
	end

	test "should search for article with nonexisting tag" do
	  assert_equal('@articles.count', 0) do
	    post articles_path, params: { tag: 'abcde' }
	  end
	  assert_redirected_to articles_path
	end

	test "should search for article with existing title" do
	  assert_equal('@articles.count', 1) do
	    post articles_path, params: { query: 'SOME TITLE' }
	  end
	  assert_redirected_to articles_path
	end

	test "should search for article with nonexisting title" do
	  assert_equal('@articles.count', 0) do
	    post articles_path, params: { title: 'abcde' }
	  end
	  assert_redirected_to articles_path
	end
end
