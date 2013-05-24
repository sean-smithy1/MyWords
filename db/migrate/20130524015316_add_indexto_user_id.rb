class AddIndextoUserId < ActiveRecord::Migration

  def up
    change_column :lists, :user_id, :integer, { :null => false }
    change_column :lists, :listname, :string, { :null => false }
    change_column :lists, :listtype, :string, { :null => false, :limit => 2 }
    add_index :lists, :user_id
  end

  def down
    change_column :lists, :user_id, :integer, { :null => true }
    change_column :lists, :listname, :string, { :null => true }
    change_column :lists, :listtype, :string, { :null => true, :limit => 2 }
    remove_index :lists, :user_id
  end
end
