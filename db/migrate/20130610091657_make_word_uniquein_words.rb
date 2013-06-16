class MakeWordUniqueinWords < ActiveRecord::Migration
  def up
    change_column :words, :word, :string, :limit => 35
    add_index :words, :word, :unique => true
  end

  def down
    remove_index :words, :word
  end
end
