module Api
	module V1
		class TreatmentsController < ApplicationController

			respond_to :json
			
      api :GET, "/v1/treatments/", "Retrieves all treatments from the current user"
			error :code => 401, :desc => "Unauthorized"
      error :code => 404, :desc => "Not Found", :meta => {:anything => "No medications created yet"}
      param :token, String, :desc => "session token as header to validate the request", :required => false
      description "List all treatments, if proper session token is given"
			formats ['json']
			meta :message => "User must be logged in to access his info."
			example " {'start':'2015-02-26','finish':'2015-02-26','hour':'04:02 AM','frequency_quantity':1,'updated_at':'2015-02-26T04:45:24.313Z','medication':'Acetaminofen','frequency':'Every X hours','medication_type':'Vitamin','unit':'Unit'},{'start':'2015-02-26','finish':'2015-02-26','hour':'04:02 AM','frequency_quantity':1,'updated_at':'2015-02-26T04:45:24.643Z','medication':'Acetaminofen','frequency':'Every X hours','medication_type':'Vitamin','unit':'Unit'} "
			def index

				treatments = current_user.treatments.page(params[:page])

				render status: :created, json: treatments.to_json
			end

      api :GET, "/v1/treatments/:id", "Retrieves specified treatment data"
			error :code => 401, :desc => "Unauthorized"
      error :code => 404, :desc => "Not Found", :meta => {:anything => "No medications exist with that name"}
      param :id, String, :desc => "identifier of the specific treatment", :required => true
      description "Gives all data of certain treatment if given the right name"
			formats ['json']
      meta :message => "User must be logged in to access his info, this method is currently behaving weird"
			example "{'start':'2015-02-26','finish':'2015-02-26','hour':'04:02 AM','frequency_quantity':1,'updated_at':'2015-02-27T04:15:38.556Z','medication':'Acetaminofen','frequency':'Every X hours','medication_type':'Vitamin','unit':'Unit'}"         
			def show

				treatment = Treatment.find(params[:id])

				if not treatment.blank?
					render status: :ok, json: treatment.to_json
				else
					render status: :bad_request, json: "Treatment not found"
				end 
			end

      api :POST, "/v1/treatments/", "Creates a new treatment on database, using the current user"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
      param :medication_name, String, :desc => "The name of the medicine we want the treatment to have, ex: 'Vicodin'", :required => true
      param :finish, String, :desc => "time when the treatment ends, ex:'2015-03-05' ", :required => true
      param :hour, String, :desc => "time when the medicine should be taken, ex: '20:17'", :required => true
      param :frequency, String, :desc => "Every how much hour the treatment should be taken, ex: '4' ", :required => true
      param :token, String, :desc => "token as HEADER, wich identifies the user session", :required => false
      description "with proper params retrieves a recently created treatment info on json format"
			formats ['json']
      meta :message => "name must be unique trought the app, or it will be created if it doesnt exist"
			example "{'id':45,'start':'2015-03-03','finish':'2015-03-05','hour':' 8:03 PM','frequency':4,'user_id':21,'medication_id':45,'created_at':'2015-03-03T21:19:27.192Z','updated_at':'2015-03-03T21:19:27.192Z','medication':'Acacelcer'}"
			def create


				medication = Medication.find_by_name(params[:medication_name])
				
				if medication.blank?
					medication = Medication.new
					medication.name = params[:medication_name]
					if not medication.save!
						render status: 500, json: medication.errors
						return
					end
				end

				treatment = Treatment.new
				treatment.medication_id = medication.id
				treatment.start = Date.today
				treatment.finish = params[:finish].to_date.strftime("%Y-%m-%d")
				treatment.hour = params[:hour]
				treatment.frequency = params[:frequency]
				treatment.user_id = current_user.id

				if treatment.save
					render status: :created, json: treatment.to_json
				else
					render status: :bad_request, json: treatment.errors
				end
			end

			def destroy
				treatment = Treatment.find(params[:id])

				if treatment.destroy
					render status: :ok, json: treatment.to_json
				else
					render status: :bad_request, json: treatment.errors
				end
			end

			def treatment_delete

				id = Medication.where(name: params[:medication_name]).take.id
				treatment = Treatment.where(medication_id: id)
															.where(finish: params[:finish].to_date.strftime("%Y-%m-%d"))
															.where(hour: params[:hour])
															.where(frequency: params[:frequency]).take

				if treatment.destroy
					render status: :ok, json: treatment.to_json
				else
					render status: :bad_request, json: treatment.errors
				end
			end
      
      api :GET, "/v1/treatments/take", "Retrieves specified treatment data"
			error :code => 401, :desc => "Unauthorized"
      error :code => 404, :desc => "Not Found", :meta => {:anything => "No medications exist with that name"}
      param :id, String, :desc => "identifier of the specific treatment", :required => true
      description "Gives all data of certain treatment if given the right name"
			formats ['json']
      meta :message => "User must be logged in to access his info, this method is currently behaving weird"
			example "{'start':'2015-02-26','finish':'2015-02-26','hour':'04:02 AM','frequency_quantity':1,'updated_at':'2015-02-27T04:15:38.556Z','medication':'Acetaminofen','frequency':'Every X hours','medication_type':'Vitamin','unit':'Unit'}"      
			def take 
				treatment = Treatment.find(params[:id])

				if treatment.touch
					render status: :ok, json: treatment.to_json
				else
					render status: :bad_request, json: treatment.errors
				end
			end

		end
	end
end
