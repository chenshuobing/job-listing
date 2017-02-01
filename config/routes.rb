Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # resources :jobs
 namespace :admin do
   resources :jobs do
     collection do
       get :internet_electronic_commerce
       get :finace_investment_security
       get :cars_auto_parts
       get :estate
     end
     member do

       post :publish
       post :hide
     end
     resources :resumes
   end
 end
 resources :jobs do
   collection do
     get :internet_electronic_commerce
     get :finace_investment_security
     get :cars_auto_parts
     get :estate
   end
    resources :resumes
 end
 #root 'jobs#index'
root 'welcome#index'
end
