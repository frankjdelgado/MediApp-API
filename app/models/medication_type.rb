class MedicationType < ActiveRecord::Base
	has_many :treatments
end
