class List < ActiveRecord::Base

  validates :user_id, presence: true
  validates :listname, presence: true, length: { :maximum => 45 }
  validates :listtype, length: { :maximum => 1 }, format: {:with => /\Au|s|f\Z/}

  belongs_to :user
  has_many :lists_words, :dependent => :delete_all
  has_many :words, through: :lists_words

  accepts_nested_attributes_for :words, allow_destroy: true

  def max_words?
    if self.words.count >= 100
      true
    else
      false
    end
  end

end

