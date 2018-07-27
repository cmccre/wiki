class RemoveRevisions < ActiveRecord::Migration[5.2]
  def change
  	drop_table :revisions
  	remove_column :articles, :revision_id
  	add_column :articles, :title, :string
  	add_column :articles, :content, :text
  	add_column :articles, :user_id, :integer
    add_index :articles, :user_id
  end
end
