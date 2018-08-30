require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  test "should not save article without content or user"  do
  	article = Article.create(title: "a")
  	assert_not article.save, "saved article without content or user"
  end

  test "should not save article without title or user"  do
  	article = Article.create(content: "a")
  	assert_not article.save, "saved article without title or user"
  end

  test "should not save article without title or content"  do
  	article = Article.create(user_id: 1)
  	assert_not article.save, "saved article without title or content"
  end

  test "should not save article without title"  do
  	article = Article.create(content: "a", user_id: 1)
  	assert_not article.save, "saved article without title"
  end

  test "should not save article without valid title"  do
  	article = Article.create(title: "", content: "a", user_id: 1)
  	assert_not article.save, "saved article without valid title"
  end

  test "should not save article without content"  do
  	article = Article.create(title: "a", user_id: 1)
  	assert_not article.save, "saved article without content"
  end

  test "should not save article without valid content"  do
  	article = Article.create(title: "a", content: "", user_id: 1)
  	assert_not article.save, "saved article without valid content"
  end

  test "should not save article without user"  do
  	article = Article.create(title: "a", content: "a")
  	assert_not article.save, "saved article without user"
  end

  test "should not save article without valid user"  do
  	article = Article.create(title: "a", content: "a", user_id: 0)
  	assert_not article.save, "saved article without valid user"
  end

  test "should not save article without title, content, or user"  do
  	article = Article.new
  	assert_not article.save, "saved article without title, content, or user"
  end

  test "should not save article without valid title, content, and user"  do
  	article = Article.create(title: "", content: "", user_id: 0)
  	assert_not article.save, "saved article without valid title, content, and user"
  end

  test "should save article with valid title, content, and user"  do
  	user = User.create(username: "alice", password: "password")
  	article = Article.create(title: "a", content: "a", user_id: user.id)
  	assert article.save, "did not save article with valid title, content, and user"
  end

end
