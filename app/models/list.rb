class List < ActiveRecord::Base
  attr_accessible :user_id, :listname, :listtype, :words_attributes

  validates :user_id, presence: true
  validates :listname, presence: true, length: { :maximum => 45 }
  validates :listtype, length: { :maximum => 1 }, format: {:with => /\Au|s\Z/}

  belongs_to :user
  has_many :lists_words
  has_many :words, through: :lists_words

  accepts_nested_attributes_for :words

end

