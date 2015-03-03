module Api
	module V1
		class TreatmentsController < ApplicationController

			respond_to :json
			
			def index

				treatments = current_user.treatments.page(params[:page])

				render status: :created, json: treatments.to_json
			end

			def show

				treatment = Treatment.find(params[:id])

				if not treatment.blank?
					render status: :ok, json: treatment.to_json
				else
					render status: :bad_request, json: "Treatment not found"
				end 
			end

			def create


				medication = Medication.find_by_name(params[:medication_name])
				
				if medication.blank?
					medication = Medication.new
					medication.name = params[:medication_name]
					if not medication.save
						render status: 500, json: medication.errors
						return
					end
				end

				treatment = Treatment.new
				treatment.medication_id = medication.id
				treatment.start = Date.today
				treatment.finish = params[:finish].to_date.strftime("%Y-%m-%d")
				treatment.hour = params[:hour].to_date.to_time.strftime("%l:%m %p")
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
					render status: :ok, json:"Treatment Deleted."
				else
					render status: :bad_request, json: treatment.errors
				end
			end

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
