class DropOldHabtmTable < ActiveRecord::Migration
  def up
    drop_table :lists_words
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
