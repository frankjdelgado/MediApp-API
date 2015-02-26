module Api
	module V1
		class UsersController < ApplicationController
			
			respond_to :json

			api :GET, "/v1/users/:id", "Retrieves user data"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
      param :id, String, :desc => "Users mail", :required => false
			param :email, String, :desc => "Users mail", :required => true
			description "user id on Url + email on params retrieves the users info"
			formats ['json']
			meta :message => "User must be logged in to access his info."
			example " 'name':'Jane Doe','email':'mail@gmail.com','role':1,'created_at':'2015-02-07T21:58:02.643Z','updated_at':'2015-02-07T21:58:02.643Z ' "
			def show
				
				user = User.find_by_email(params[:email])

				if not user.blank?
					render status: :ok, json: user.to_json
				else
					render status: :ok, json: "User not found"
				end
			end

			api :POST, "/v1/users/", "Creates a new user on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
			param :name, String, :desc => "Users Name to be used on the App", :required => true
			param :email, String, :desc => "Users mail", :required => true
			param :password, String, :desc => "Users access password", :required => true
			description "with proper params retrieves a recently created user info on json format"
			formats ['json']
			meta :message => "email must be unique trought the app"
			example " 'name':'Jane Doe','email':'mail@gmail.com','role':1,'created_at':'2015-02-07T21:58:02.643Z','updated_at':'2015-02-07T21:58:02.643Z ' "
			def create
        
				user = User.new(user_params)

			    if user.save
			    	render status: :created, json: user.to_json
			    else
			    	render status: :bad_request, json: user.errors
			    end
			end


			api :PUT, "/v1/users/:id", "Updates a user data on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
			param :name, String, :desc => "Users Name to be used on the App", :required => true
			param :email, String, :desc => "Users mail", :required => true
			param :password, String, :desc => "Users access password", :required => true
      param :password_confirmation, String, :desc => "Users access password", :required => true
			param :role, Integer, :desc => "Users role for the app", :required => false
			description "with at least one updated user value, the method retrieves the modified user info on json format"
			formats ['json']
			meta :message => "A User session must be active"
			example " 'name':'Jane Doe','email':'mail11@gmail.com','role':1,'created_at':'2015-02-07T21:58:02.643Z','updated_at':'2015-02-07T21:58:02.643Z ' "
			def update
				
        user = User.find_by_email(params[:email])

				if user.update(user_params)
					render status: :ok, json: user.to_json
				else
					render status: :bad_request, json: user.errors
				end
			end

			api :DELETE, "/v1/users/:id", "Destroys  Users record on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 406, :desc => "Bad Request"
			param :email, String, :desc => "Users mail", :required => true
			description "User must exist to be destroyed"
			formats ['json']
			meta :message => "A User Session must be active"
			example " ok "
			def destroy

				user = User.find_by_email(params[:email])
        if not user.blank?
          if user.destroy
            render status: :ok, json:"User deleted"
          else
            render status: :bad_request, json: user.errors
          end
        else
          render status: :ok, json: "User not found"
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
        params.permit(:email, :name, :password, :role, :password_confirmation)
			end

		end
	end
end
