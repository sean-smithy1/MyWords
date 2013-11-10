class List < ActiveRecord::Base

  validates :user_id, presence: true
  validates :listname, presence: true, length: { :maximum => 45 }
  validates :listtype, length: { :maximum => 1 }, format: {:with => /\Au|s|f\Z/}
  validate :max_words

  belongs_to :user, :dependent => :destroy

  has_many :lists_words
  has_many :words, through: :lists_words, :dependent => :delete_all

  accepts_nested_attributes_for :words, allow_destroy: true
  validates_associated :words

  def max_words
    errors.add(:max_words, "100 maximun words per list") if words.count > 100
  end


end

