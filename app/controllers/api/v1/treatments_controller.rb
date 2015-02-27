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

			def create

				treatment = Treatment.new(treatment_params)
				treatment.start = params[:treatment][:start].to_date.strftime("%Y-%m-%d")
				treatment.finish = params[:treatment][:start].to_date.strftime("%Y-%m-%d")

				if treatment.save
					render status: :created, json: treatment.to_json
				else
					render status: :bad_request, json: treatment.errors
				end
			end

			def destroy
				treatment = Treatment.find(params[:id])

				if treatment.destroy
					render status: :ok, json:"Treatment Deleted."
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

			private

			def treatment_params
				params.permit(:start, :finish, :hour, :frequency_quantity, :frequency_id, :user_id, :medication_id)
			end
		end
	end
end
