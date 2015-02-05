module Api
	module V1
		class SessionsController < ApplicationController

			respond_to :json

			# Create session
			def create

				user = User.find_by_email(request.headers["email"])

				response = Hash.new

			    if user && user.authenticate(request.headers["password"])
			      
			      	# Delete session token if exists
					user.session.delete if user.session

					# Create new session
					session = Session.new(token: generate_token)
					session.user = user

					if session.save
						response["token"] = session.token
						response["user"] = user
						render status: :created, json: response
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
