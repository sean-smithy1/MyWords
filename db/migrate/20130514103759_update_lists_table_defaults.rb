class UpdateListsTableDefaults < ActiveRecord::Migration
  def up
    change_column :lists, :listtype, :string, :limit => 2, :default => "u"
  end

  def down
  end
end
