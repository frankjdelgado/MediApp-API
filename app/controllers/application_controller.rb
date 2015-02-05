class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

	# Generate an unique token
	def generate_token

		# Generate random token untill is unique
		begin
			new_token = SecureRandom.base64(64)
			tokens = Session.all.map{ |t| t.token}
		end while tokens.include? new_token

		return new_token
	end

	def current_user
        Session.find_by_token(request.headers["token"]).user
    end

	def validate_token

        # Get token active record
        session = Session.find_by_token(request.headers["token"])

        # Check if session exists and have valid user
        if session.blank?
            render status: :unauthorized, json: "Invalid token"
        end
    end

    def validate_admin
        if not current_user.is_admin?
            render status: :unauthorized, json: "You can't access this resource"
        end
    end

end
