class AddChoreCycleToUser < ActiveRecord::Migration
  def change
    add_column :users, :choreCycle, :string
  end
end
