Rails.application.routes.draw do
  resources :quotes
  resources :characters
  root 'characters#index'
  
end
