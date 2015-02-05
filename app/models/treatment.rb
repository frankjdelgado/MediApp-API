class Treatment < ActiveRecord::Base
	belongs_to :user
	belongs_to :medication
	belongs_to :medication_type
	belongs_to :unit
	belongs_to :frequency

	validates :user_id, presence: true
	validates :medication_id, presence: true
	validates :frequency_id, presence: true
	validates :frequency_quantity, presence: true
	validates :start, presence: true
	validates :finish, presence: true
	validates :hour, presence: true

	paginates_per 10

	def as_json(options = nil)
		hash_info = super({ only: [:frequency_quantity, :start, :finish, :hour, :updated_at] }.merge(options || {}))
		hash_info[:medication] = medication.name
		hash_info[:frequency] = frequency.value
		hash_info[:medication_type] = medication_type.value
		hash_info[:unit] = unit.value
		hash_info
	end
end
