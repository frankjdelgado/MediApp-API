module Api
	module V1
		class MedicationsController < ApplicationController

			respond_to :json

			def index
				
				meds = Medication.page(params[:page])

				render status: :created, json: meds.to_json
			end

      def show
				
        medication = Medication.find_by_name(params[:name])

				if not medication.blank?
					render status: :ok, json: medication.to_json
				else
					render status: :ok, json: "Medication not found"
				end
			end
      
			def create

				med = Medication.new(medication_params)

			    if med.save
			    	render status: :created, json: med.to_json
			    else
			    	render status: :bad_request, json: med.errors
			    end
			end

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
