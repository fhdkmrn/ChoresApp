class CreateChoresLists < ActiveRecord::Migration[5.1]
  def change
    create_table :chores_lists do |t|
      t.text :options
    end
  end
end
