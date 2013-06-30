class CreateListWordHasManyThroughTable < ActiveRecord::Migration
  def up
    create_table "lists_words", id: false, force: true do |t|
      t.integer  "list_id", null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "word_id", null: false
    end
      add_index(:lists_words, [:list_id, :word_id], unique: true)

  end

  def down
    drop_table :lists_words
  end
end
