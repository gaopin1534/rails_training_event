class AddUserIdToEvents < ActiveRecord::Migration
  def up
    add_column :Events, :user_id, :integer
  end
end
