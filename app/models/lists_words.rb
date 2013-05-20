class lists_words < ActiveRecord::Base
  belongs_to :List
  belongs_to :Word
end