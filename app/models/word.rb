class Word < ActiveRecord::Base

  validates :word, presence: true, length: { maximum: 45 }

  has_many :lists_words
  has_many :lists, through: :lists_words

  # before_destroy :ensure_not_referenced_by_any_list


end
