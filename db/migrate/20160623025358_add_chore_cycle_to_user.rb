class AddChoreCycleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :choreCycle, :string
  end
end
