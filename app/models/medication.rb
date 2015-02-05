class Medication < ActiveRecord::Base

	has_many :treatments

	default_scope { order(name: :asc) }

	paginates_per 25

	def self.search(query)
		where("name like ?", "%#{query}%")
	end

	def as_json(options = nil)
		super({ except: [:id] }.merge(options || {}))
	end
end
