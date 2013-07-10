class Word < ActiveRecord::Base
  attr_accessible :word, :id

  validates :word, presence: true, length: { maximum: 45 }

  has_many :lists_words
  has_many :lists, through: :lists_words
  
end
