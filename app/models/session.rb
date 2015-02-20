class Session < ActiveRecord::Base

	belongs_to :user

	def as_json(options = nil)
		super({ except: [:id] }.merge(options || {}))
	end
end
