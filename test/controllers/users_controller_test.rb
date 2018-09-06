require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	include Devise::Test::ControllerHelpers
	
	test "should not get user index without signing in" do
	  	get :index
	  	assert_redirected_to new_user_session_path
	  	assert_equal "index", @controller.action_name
	end

	test "should get user index with one admin user" do
		user = create(:user, :admin)
		sign_in user
		get :index
	  	assert_equal assigns[:users].count, 1
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	end

	test "should get user index with one admin and one editing user" do
		create(:user)
		user = create(:user, :admin)
		sign_in user
		get :index
	  	assert_equal assigns[:users].count, 2
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	end

	test "should get user index with one admin and one banned user" do
		create(:user, :banned)
		user = create(:user, :admin)
		sign_in user
		get :index
	  	assert_equal assigns[:users].count, 2
	  	assert_response :success
	  	assert_equal "index", @controller.action_name
	end

	test "should not get user show without signing in" do
		user = create(:user)
	  	get :show, params: { id: user.id }
	  	assert_redirected_to new_user_session_path
	  	assert_equal "show", @controller.action_name
	end

	test "should get user show with one admin user" do
		user = create(:user, :admin)
		sign_in user
		get :show, params: { id: user.id }
	  	assert_response :success
	  	assert_equal "show", @controller.action_name
	end

	test "should get user show with one admin and one editing user" do
		user1 = create(:user)
		user = create(:user, :admin)
		sign_in user
	  	get :show, params: { id: user1.id }
	  	assert_response :success
	  	assert_equal "show", @controller.action_name
	end

	test "should get user show with one admin and one banned user" do
		user1 = create(:user, :banned)
		user = create(:user, :admin)
		sign_in user
	  	get :show, params: { id: user1.id }
	  	assert_response :success
	  	assert_equal "show", @controller.action_name
	end
end