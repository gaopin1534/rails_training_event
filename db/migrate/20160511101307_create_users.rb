class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.text :description
      t.string :image
      t.integer :uid
      t.string :token
      t.string :secret

      t.timestamps null: false
    end
  end
end
