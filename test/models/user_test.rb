require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without username or password" do
  	user = User.new
  	assert_not user.save, "saved user without username or password"
  end

  test "should not save user without username" do
  	user = User.create(password: "password")
  	assert_not user.save, "saved user without username"
  end

  test "should not save user without valid username" do
  	user = User.create(username: nil, password: "password")
  	assert_not user.save, "saved user without valid username"
  end

  test "should not save user without password" do
  	user = User.create(username: "user")
  	assert_not user.save, "saved user without password"
  end

  test "should not save user without valid password" do
  	user = User.create(username: "user", password: "")
  	assert_not user.save, "saved user without valid password"
  end

  test "should not save user without valid username or password" do
  	user = User.create(username: nil, password: "")
  	assert_not user.save, "saved user without valid username or password"
  end

  test "should save user with valid username and password" do
  	user = User.create(username: "user", password: "password")
  	assert user.save, "did not save user with valid username and password"
  end

  test "should not save user with duplicate username" do
  	user1 = User.create(username: "user", password: "password1")
  	user1.save
  	user2 = User.create(username: "user", password: "password2")
  	assert_not user2.save, "saved user with duplicate username"
  end

  test "should save user with duplicate password" do
  	user1 = User.create(username: "user1", password: "password")
  	user1.save
  	user2 = User.create(username: "user2", password: "password")
  	assert user2.save, "did not save user with duplicate password"
  end

end
