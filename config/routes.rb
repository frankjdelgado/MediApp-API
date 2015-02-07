Rails.application.routes.draw do

  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    	resources :users, except: [:index, :new] do
			collection do
				get 'recover_password'
			end 
		end
  		resources :sessions, only: [:create]
  		resources :treatments, except: [:new, :show] do
			collection do
				get 'take'
			end 
		end
    end
  end
  
end
