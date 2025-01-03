# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
             controllers: {
               sessions: 'users/sessions',  # Custom sessions controller
               registrations: 'users/registrations'
             }

  # Example of protected routes that require authentication
  resources :uploaded_files, only: [:index, :create, :destroy]
end
