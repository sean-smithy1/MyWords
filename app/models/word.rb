class Word < ActiveRecord::Base

  validates :word, presence: true, length: { maximum: 45 }
  validates :word, format: { with: /\A[a-zA-Z']+\Z/ }
  has_many :lists_words
  has_many :lists, through: :lists_words, inverse_of: :words

  # before_destroy :ensure_not_referenced_by_any_list

end
