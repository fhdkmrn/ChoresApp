class CreateChoreLists < ActiveRecord::Migration[5.1]
  def change
    create_table :chore_lists do |t|
      t.text :options
    end
  end
end
