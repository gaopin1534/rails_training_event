class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :hold_at
      t.integer :capacity
      t.string :location
      t.integer :owner
      t.text :description

      t.timestamps null: false
    end
  end
end
