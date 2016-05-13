class ChangeOwnerOfEvents < ActiveRecord::Migration
  def self.up
  change_column :Events, :owner, :string, :null => false, :default => ""
  end

  def self.down
    change_column :Events, :owner, :integer,:limit => nil ,:null => true,:default => nil
  end
end
