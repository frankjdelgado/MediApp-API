class User < ActiveRecord::Base

	has_secure_password

	has_many :treatments, dependent: :destroy
	has_one :session, dependent: :destroy

	# Validations
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
	validates :password, length: {minimum: 6}
	validates_inclusion_of :role, :in => 0..1

	scope :admins, -> { where(role: 1) }

	def is_admin?
		if role
			return true
		else
			return false
		end
	end
	
	def as_json(options = nil)
		super({ except: [:password_digest] }.merge(options || {}))
	end
end
