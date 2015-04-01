class Treatment < ActiveRecord::Base
	belongs_to :user
	belongs_to :medication

	validates :user_id, presence: true
	validates :medication_id, presence: true
	validates :frequency, presence: true
	validates :start, presence: true
	validates :finish, presence: true
	validates :hour, presence: true

	validates_inclusion_of :frequency, :in => 1..24

	paginates_per 10

	def as_json(options = nil)
		hash_info = super({}.merge(options || {}))
		hash_info[:name] = medication.name
		hash_info
	end
end
