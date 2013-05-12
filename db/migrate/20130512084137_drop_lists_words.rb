class DropListsWords < ActiveRecord::Migration
  def up
    drop_table :wordslists
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
