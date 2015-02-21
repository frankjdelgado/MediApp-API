module Api
	module V1
		class MedicationsController < ApplicationController

			respond_to :json
      
      api :GET, "/v1/medications/", "Retrieves all medicines data"
			error :code => 401, :desc => "Unauthorized"
      error :code => 404, :desc => "Not Found", :meta => {:anything => "No medications created yet"}
      param :page, String, :desc => "Medicine page in case of pagination", :required => false
      description "List all medicines or specific pages if parameters are given"
			formats ['json']
			meta :message => "User must be logged in to access his info."
			example" [{'name':'Insulin','description':'Diabetes drugs','created_at':'2015-02-20T01:07:12.740Z','updated_at':'2015-02-20T01:15:01.769Z'},{'name':'Vicodin','description':'Powerfull Painkiller','created_at':'2015-02-20T01:06:15.368Z','updated_at':'2015-02-20T01:06:15.368Z'}] "
			def index
				
				meds = Medication.page(params[:page])

				render status: :created, json: meds.to_json
			end

      api :GET, "/v1/medications/:id", "Retrieves specified medicine data"
			error :code => 401, :desc => "Unauthorized"
      error :code => 404, :desc => "Not Found", :meta => {:anything => "No medications exist with that name"}
      param :name, String, :desc => "Name of the specific medicine", :required => true
      description "Gives all data of certain medicine if given the right name"
			formats ['json']
			meta :message => "User must be logged in to access his info."
			example "{'name':'Vicodin','description':'Powerfull Painkiller','created_at':'2015-02-20T01:06:15.368Z','updated_at':'2015-02-20T01:06:15.368Z'} "     
      def show
				
        medication = Medication.find_by_name(params[:name])

				if not medication.blank?
					render status: :ok, json: medication.to_json
				else
					render status: :ok, json: "Medication not found"
				end
			end
    
      api :POST, "/v1/medications/", "Creates a new medicine on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
			param :name, String, :desc => "Users Name to be used on the App", :required => true
      param :description, String, :desc => "Medicine brief description", :required => true
      description "with proper params retrieves a recently created medicine info on json format"
			formats ['json']
      meta :message => "name must be unique trought the app"
			example " {'name':'faralina','description':'miasma drug','created_at':'2015-02-21T03:19:22.710Z','updated_at':'2015-02-21T03:19:22.710Z'} "
			def create

				med = Medication.new(medication_params)

			    if med.save
			    	render status: :created, json: med.to_json
			    else
			    	render status: :bad_request, json: med.errors
			    end
			end

      api :PUT, "/v1/medications/:id", "Updates a medicine data on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 404, :desc => "Not Found", :meta => {:anything => "could generate this error"}
			param :name, String, :desc => "Users Name to be used on the App", :required => true
      param :description, String, :desc => "Medicine brief description", :required => true
      description "with at least the name value, the method retrieves the modified medication info on json format"
			formats ['json']
      meta :message => "Name is the main param, without if wont fin the medicine"
			example "{'name':'faralina','description':'meyosis duga','created_at':'2015-02-21T03:19:22.710Z','updated_at':'2015-02-21T03:26:44.853Z'} "
    	def update
       
         medication = Medication.find_by_name(params[:name])

				if not medication.blank?
          if medication.update(medication_params)
            render status: :ok, json: medication.to_json
          else
            render status: :bad_request, json: medication.errors
          end
				else
					render status: :ok, json: "Medication not found"
				end
      end
      
      api :DELETE, "/v1/medications/:id", "Destroys  a Medication record on database"
			error :code => 401, :desc => "Unauthorized"
			error :code => 406, :desc => "Bad Request"
      param :name, String, :desc => "Medication name", :required => true
      description "Medication must exist to be destroyed"
			formats ['json']
      meta :message => "Name is essential to find the right record"
			example "Medication Deleted."
			def destroy

        med = Medication.find_by_name(params[:name])
        if not med.blank?
          if med.destroy
            render status: :ok, json:"Medication Deleted."
          end
        else
					render status: :ok, json: "Medication not found"
				end
			end
        	
			private

			def medication_params
				params.permit(:name, :description)
			end
		end
	end
end
