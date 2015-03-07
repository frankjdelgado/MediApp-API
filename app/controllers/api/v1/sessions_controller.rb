module Api
	module V1
		class SessionsController < ApplicationController

			respond_to :json

			# Create session
			def create

				user = User.find_by_email(request.headers["email"])

				response = Hash.new

			    if user && user.authenticate(request.headers["password"])
			      
			      	session = user.session

					if not session.blank?
						session.token = generate_token
					else
						session = Session.new(token: generate_token, user_id: user.id)
					end

					if session.save
						render status: :created, json: session.to_json
						return
					else
						render status: :internal_server_error, json: session.errors
						return
					end

			    else
			    	response["message"] = "Specified data is invalid"
			    	render status: :bad_request, json: response
			    end

			end

		end
	end
end
