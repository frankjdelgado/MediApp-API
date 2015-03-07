class Session < ActiveRecord::Base

	belongs_to :user

	def as_json(options = nil)
		hash_info = super({ except: [:id] }.merge(options || {}))
		hash_info[:user] = {name: user.name, email: user.email, role: user.role}
		hash_info
	end
end
