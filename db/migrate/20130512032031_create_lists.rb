class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :listname
      t.boolean :listtype
      t.integer :user_id

      t.timestamps
    end
    add_index :lists, [ :user_id ]
  end
end
