class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :text
  end
end
