class CreateListsWords < ActiveRecord::Migration
  def change
    create_table :lists_words, :id => false do |t|
      t.integer :words_id
      t.integer :lists_id
    end
  end
end
