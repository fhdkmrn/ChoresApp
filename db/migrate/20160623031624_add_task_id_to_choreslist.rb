class AddTaskIdToChoreslist < ActiveRecord::Migration
  def change
    add_column :choreslists, :taskID, :integer
  end
end
