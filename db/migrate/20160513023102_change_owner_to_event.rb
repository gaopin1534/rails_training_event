class ChangeOwnerToEvent < ActiveRecord::Migration
  def change
    def up
      change_column :Events, :owner, :string, null: false, default: 0
    end

    #変更前の型
    def down
      change_column :Events, :owner, :intger, null: true
    end
  end
end
