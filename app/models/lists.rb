class Lists < ActiveRecord::Base
  attr_accessible :listname


  validates :id, presence: true
  validates :listname, presence: true, length: { maximum: 45 }
  validates :listtype, presence: true, length: { maximum: 1 }

  belongs_to :users
  has_and_belongs_to_many :Words
end
