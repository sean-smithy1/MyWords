class Lists < ActiveRecord::Base
  attr_accessible :listname

  validates :listname, presence: true, length: { maximum: 45 }
  validates :listtype, presence: true, length: { maximum: 1 }

  belongs_to :user
  has_and_belongs_to_many :Words

  accepts_nested_attributes_for :Words, :allow_destroy => true
end
