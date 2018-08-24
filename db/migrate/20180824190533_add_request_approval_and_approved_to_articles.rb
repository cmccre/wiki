class AddRequestApprovalAndApprovedToArticles < ActiveRecord::Migration[5.2]
  def change
  	add_column :articles, :request_approval, :boolean
  	add_column :articles, :approved, :boolean
  end
end
