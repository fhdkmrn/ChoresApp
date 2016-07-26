class CreateChoresLists < ActiveRecord::Migration
  def change
    create_table :chores_lists do |t|
      t.text :options
    end
  end
end
