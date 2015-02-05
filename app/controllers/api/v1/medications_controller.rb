module Api
	module V1
		class MedicationsController < ApplicationController

			respond_to :json

			def index
				
				meds = Medication.page(params[:page])

				render status: :created, json: meds.to_json
			end

			def create

				med = Medication.new(medication_params)

			    if med.save
			    	render status: :created, json: med.to_json
			    else
			    	render status: :bad_request, json: med.errors
			    end
			end

			def destroy

				med = Medication.find(params[:id])

				if med.destroy
					render status: :ok, json:"Medication Deleted."
				else
					render status: :bad_request, json: med.errors
				end
			end
			
			private

			def medication_params
				params.permit(:name, :description)
			end
		end
	end
end
