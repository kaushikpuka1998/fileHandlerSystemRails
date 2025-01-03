# config/routes.rb
Rails.application.routes.draw do

  post '/login', to: 'authentication#login'
  devise_for :users, defaults: { format: :json },
             controllers: {
               registrations: 'users/registrations'
             }

  devise_scope :user do
  # Custom routes for uploading and fetching files
    post 'users/upload', to: 'users#upload'
    get 'users/files', to: 'users#files'
    post 'users/files/delete', to: 'users#delete_file'
  end


  get '/s/:short_code', to: 'short_url#redirect', as: :shortened
end
