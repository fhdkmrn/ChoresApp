class AddApprovalsToUser < ActiveRecord::Migration
  def change
    add_column :users, :tags, :string
  end
end
