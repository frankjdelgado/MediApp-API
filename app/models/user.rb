class User < ActiveRecord::Base

	has_secure_password

	has_many :treatments

	# Validations
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
	validates :password, length: {minimum: 6}
	
end
