class ListsWord < ActiveRecord::Base
	# attr_accessible :list_id, :word_id

	belongs_to :list
	belongs_to :word

end
