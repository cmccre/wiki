class DropArticleTagsJoinTagsAndTaggings < ActiveRecord::Migration[5.2]
  def change
  	drop_table :articles_tags_joins
  	drop_table :tags
  	drop_table :taggings
  end
end
