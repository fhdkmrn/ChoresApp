class AddApprovalListToUser < ActiveRecord::Migration
  def change
    add_column :users, :approvalLists, :string, array: true, default: []
  end
end
