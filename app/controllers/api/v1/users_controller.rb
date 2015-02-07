module Api
	module V1
		class UsersController < ApplicationController
			
			respond_to :json

			api :GET, "/users/:id", "Show user profile"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "you can think of"}
			param :session, String, :desc => "user is logged in", :required => true
			param :regexp_param, /^[0-9]* years/, :desc => "regexp param"
			param :array_param, [100, "one", "two", 1, 2], :desc => "array validator"
			param :boolean_param, [true, false], :desc => "array validator with boolean"
			param :proc_param, lambda { |val|
			  val == "param value" ? true : "The only good value is 'param value'."
			}, :desc => "proc validator"
			param :param_with_metadata, String, :desc => "", :meta => [:your, :custom, :metadata]
			description "method description"
			formats ['json', 'jsonp', 'xml']
			meta :message => "Some very important info"
			example " 'user': {...} "
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

			resource_description do
			  short 'Site members'
			  formats ['json']
			  param :id, Fixnum, :desc => "User ID", :required => false
			  param :resource_param, Hash, :desc => 'Param description for all methods' do
			    param :ausername, String, :desc => "Username for login", :required => true
			    param :apassword, String, :desc => "Password for login", :required => true
			  end
			  api_version "development"
			  error 404, "Missing"
			  error 500, "Server crashed for some <%= reason %>", :meta => {:anything => "you can think of"}
			  meta :author => {:name => 'John', :surname => 'Doe'}
			  description <<-EOS
			    == Long description
			     Example resource for rest api documentation
			     These can now be accessed in <tt>shared/header</tt> with:
			       Headline: <%= headline %>
			       First name: <%= person.first_name %>

			     If you need to find out whether a certain local variable has been
			     assigned a value in a particular render call, you need to use the
			     following pattern:

			     <% if local_assigns.has_key? :headline %>
			        Headline: <%= headline %>
			     <% end %>

			    Testing using <tt>defined? headline</tt> will not work. This is an
			    implementation restriction.

			    === Template caching

			    By default, Rails will compile each template to a method in order
			    to render it. When you alter a template, Rails will check the
			    file's modification time and recompile it in development mode.
			  EOS
			end
		end
	end
end
