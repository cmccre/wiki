class DropCategory < ActiveRecord::Migration[5.2]
  def change
  	drop_table :categories
  	remove_column :articles, :category_id
  end
end
