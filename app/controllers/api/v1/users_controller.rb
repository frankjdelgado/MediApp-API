module Api
	module V1
		class UsersController < ApplicationController
			
			respond_to :json

			api :GET, "/users/:id", "Shows the user profile"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
			param :email, String, :desc => "Users mail", :required => true
			# param :regexp_param, /^[0-9]* years/, :desc => "regexp param"
			# param :array_param, [100, "one", "two", 1, 2], :desc => "array validator"
			# param :boolean_param, [true, false], :desc => "array validator with boolean"
			# param :proc_param, lambda { |val|
			#   val == "param value" ? true : "The only good value is 'param value'."
			# }, :desc => "proc validator"
			# param :param_with_metadata, String, :desc => "", :meta => [:your, :custom, :metadata]
			description "user id on Url + email on params retrieves the users info"
			formats ['json']
			meta :message => "User must be logged in to access his info."
			example " 'name':'mela','email':'mail@gmail.com','role':1,'created_at':'2015-02-07T21:58:02.643Z','updated_at':'2015-02-07T21:58:02.643Z ' "
			def show
				
				user = User.find_by_email(params[:email])

				if not user.blank?
					render status: :ok, json: user.to_json
				else
					render status: :ok, json: "User not found"
				end
			end

			def create

				user = User.new(user_params)

			    if user.save
			    	render status: :created, json: user.to_json
			    else
			    	render status: :bad_request, json: user.errors
			    end
			end

			def update
				
				user = current_user

				if user.update(update_params)
					render status: :ok, json: user.to_json
				else
					render status: :bad_request, json: user.errors
				end
			end

			def destroy

				user = User.find_by_email(params[:email])

				if user.destroy
					render status: :ok, json:"User deleted"
				else
					render status: :bad_request, json: user.errors
				end
			end

			def recover_password
				user = current_user
				new_password = SecureRandom.base64(6)
				user.password =  new_password
				if user.save
					Medimailer.recover_account_email(user, new_password).deliver
				end
			end

			private

			def user_params
				params.permit(:email, :name, :password, :password_confirmation)
			end


		end
	end
end
