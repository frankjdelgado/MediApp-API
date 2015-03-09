module Api
	module V1
		class SessionsController < ApplicationController

			respond_to :json
      
      api :POST, "/v1/sessions/", "Creates a new session on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
      param :email, String, :desc => "Users mail, used as header on the request", :required => false
			param :password, String, :desc => "Users access password, used as header on the request", :required => false
      description "with proper HEADERS retrieves a recently created session info on json format"
			formats ['json']
			meta :message => "email must be unique trought the app"
			example "{'token':'pYcVa9Upz5bWNektfh/Z6C19hByu3HsgHYQxpwADwvFtM8Uiv1ucz67+t7nKDixGn2ymDKqJSM/a6lQGZdQScA==','user':{'name':'admin','email':'mail@gmail.com','role':0,'created_at':'2015-02-26T04:45:15.874Z','updated_at':'2015-02-26T04:45:15.874Z'}}"
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
