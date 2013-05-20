class List < ActiveRecord::Base
  attr_accessible :listname

  validates :listname, presence: true, length: { maximum: 45 }
  validates :listtype, presence: true, length: { maximum: 1 }

  belongs_to :User
  has_and_belongs_to_many :words

  def add_list_words(word)
    word.each do |word|
      self.words << word
    end
  end
end
