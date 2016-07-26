class AddChoreNameToChoreslist < ActiveRecord::Migration
  def change
    add_column :choreslists, :choreName, :string
  end
end
