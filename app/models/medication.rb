class Medication < ActiveRecord::Base

	has_many :treatments

	default_scope { order(name: :asc) }

	def self.search(query)
		where("name like ?", "%#{query}%")
	end
	
end
