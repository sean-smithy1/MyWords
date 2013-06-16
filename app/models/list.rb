class List < ActiveRecord::Base
  attr_accessible :listname, :listtype

  validates :listname, :presence => true, :length => { :maximum => 45 }
  validates :listtype, :presence => true, :length => { :maximum => 1 }, :format => {:with => /\Au|s\Z/}

  belongs_to :user
  has_and_belongs_to_many :words

end

