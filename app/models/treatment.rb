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
end
