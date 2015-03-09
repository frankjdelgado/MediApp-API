Rails.application.routes.draw do

  apipie
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :users, except: [:index, :new] do
          collection do
            get 'recover_password'
            post 'update_profile'
          end 
        end
        resources :sessions, only: [:create]
         resources :treatments, except: [:new, :show] do
          collection do
            get 'take'
            delete 'treatment_delete'
          end 
        end
      resources :medications, except: [:edit, :new] do
          collection do
            get 'take'
          end 
        end
    end
  end
  
end
