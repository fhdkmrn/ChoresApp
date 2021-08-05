class AddTradeRequestsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tradeRequests, :string, default: [].to_yaml, array: true
  end
end
