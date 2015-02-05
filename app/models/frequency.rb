class Frequency < ActiveRecord::Base
	has_many :treatments

	def as_json(options = nil)
		super({ except: [:id] }.merge(options || {}))
	end
end
