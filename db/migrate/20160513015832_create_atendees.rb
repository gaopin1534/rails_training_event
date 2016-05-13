class CreateAtendees < ActiveRecord::Migration
  def change
    create_table :atendees do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :status

      t.timestamps null: false
    end
  end
end
