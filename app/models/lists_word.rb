class ListsWord < ActiveRecord::Base

  # validates :word_id, uniqueness: { scope: :list_id, message: "word not unique" }

  belongs_to :list
  belongs_to :word

end
