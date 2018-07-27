class AddIsCurrentArticleToArticles < ActiveRecord::Migration[5.2]
  def change
  	add_column :articles, :is_current_article, :boolean
  end
end
