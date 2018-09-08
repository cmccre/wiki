require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	include Devise::Test::ControllerHelpers
	
	test "should not get user index without signing in" do
	  	get :index
	  	assert_redirected_to new_user_session_path
	  	assert_equal "index", @controller.action_name
	end

	test "should not get user index without signing in as admin" do
		user = create(:user)
		sign_in user
	  	get :index
	  	assert_redirected_to root_path
	  	assert_equal "Access Denied", flash[:alert]
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

	test "should not get user show without signing in as admin" do
		user = create(:user)
		sign_in user
	  	get :show, params: { id: user.id }
	  	assert_redirected_to root_path
	  	assert_equal "Access Denied", flash[:alert]
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

	test "should not ban editing user without signing in" do
		user1 = create(:user)
		user = create(:user, :admin)
		assert_equal user1.is_active, true
		post :toggle_is_active, params: { id: user1.id }
		assert_redirected_to new_user_session_path
	  	assert_equal "toggle_is_active", @controller.action_name
	end

	test "should not ban editing user without signing in as admin" do
		user1 = create(:user)
		user = create(:user, :admin)
		sign_in user1
		assert_equal user.is_active, true
		post :toggle_is_active, params: { id: user.id }
		assert_redirected_to root_path
	  	assert_equal "Access Denied", flash[:alert]
	  	assert_equal "toggle_is_active", @controller.action_name
	end

	test "should ban editing user" do
		user1 = create(:user)
		user = create(:user, :admin)
		sign_in user
		assert_equal user1.is_active, true
		put :toggle_is_active, params: { id: user1.id }
	  	assert_equal assigns[:user].is_active, false
	  	assert_redirected_to users_path
	  	assert_equal "toggle_is_active", @controller.action_name
	end

	test "should unban banned user" do
		user1 = create(:user, :banned)
		user = create(:user, :admin)
		sign_in user
		assert_equal user1.is_active, false
		put :toggle_is_active, params: { id: user1.id }
	  	assert_equal assigns[:user].is_active, true
	  	assert_redirected_to users_path
	  	assert_equal "toggle_is_active", @controller.action_name
	end
end