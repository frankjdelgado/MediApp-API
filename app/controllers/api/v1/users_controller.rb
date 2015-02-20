module Api
	module V1
		class UsersController < ApplicationController
			
			respond_to :json

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

				if user.update(user_params)
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
