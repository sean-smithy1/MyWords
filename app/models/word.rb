class Word < ActiveRecord::Base
  attr_accessible :word

  validates :word, presence: true, length: { maximum: 45 }

  has_and_belongs_to_many :lists


end
