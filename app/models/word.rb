class Word < ActiveRecord::Base
  attr_accessible :word, :id

  validates :word, presence: true, length: { maximum: 45 }

  has_many :lists_words
  has_many :lists, through: :lists_words
  
  before_destroy :ensure_not_referenced_by_any_list

  # ensure that there are no lists referencing this word
  def ensure_not_referenced_by_any_line_item
    if lists_words.empty?
      return true
    else
      errors.add(:base, 'List referencing this word')
      return false
    end
  end
end
