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
