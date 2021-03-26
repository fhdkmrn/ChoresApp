class AddDeclinedTradeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :declinedTrade, :string, default: [].to_yaml, array: true
  end
end
