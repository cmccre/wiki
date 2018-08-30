class SetDefaultsForRequestApprovalAndApproved < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :articles, :request_approval, false
  	change_column_default :articles, :approved, false
  end
end
