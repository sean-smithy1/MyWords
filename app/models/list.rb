class List < ActiveRecord::Base

  belongs_to :user

  has_many :lists_words
  has_many :words, through: :lists_words, inverse_of: :lists, order: 'word ASC'
    # dependent: :destroy
  accepts_nested_attributes_for :words
    # allow_destroy: :true

  #Validations
  validates :listname, presence: true, length: { maximum: 45, message: "List names should be less than 45 characters" }
  validates :listname, uniqueness: { scope: :user_id, message: "This list name already exists as part of your list collection" }

  #Custom Validations
   validate :max_words

  #Model Associations
  validates_associated :words

  def to_s
    self.listname
  end

private
  def max_words
    self.errors[:base]<<"100 maximun words per list" if words.length>=100
  end
end

