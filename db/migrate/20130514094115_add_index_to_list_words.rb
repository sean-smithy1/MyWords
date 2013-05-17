class AddIndexToListWords < ActiveRecord::Migration
  def change
    add_index(:lists_words,[:words_id,:lists_id])
  end
end
