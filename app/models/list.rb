class List < ActiveRecord::Base

  MAXWORDS=50
  MAXLISTS=10

  belongs_to :user

  has_many :lists_words
  has_many :words, -> { order(word: :asc) }, through: :lists_words, inverse_of: :lists

  accepts_nested_attributes_for :words

  #Validations
  validates_presence_of :listname
  validates_length_of :listname, maximum: 45, message: "List names should be less than 45 characters"
  validates_uniqueness_of :listname, scope: :user_id, message: "This list name already exists as part of your list collection"
  validate :max_words
  validates_associated :words


  def count_words
    self.words.count
  end

  def words_remaining
    MAXWORDS-count_words
  end

  def to_s
    self.listname
  end

  def self.maxwords
    50
  end

private
  def max_words
    if words.length > MAXWORDS
      self.errors[:base]<< "maximum #{MAXWORDS} words per list"
      false
    end
  end

end

