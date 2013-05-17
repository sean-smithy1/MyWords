class Words < ActiveRecord::Base
  attr_accessible :word, :lists_ids

  validates :word, presence: true, length: { maximum: 45 }
  has_and_belongs_to_many :Lists

end
