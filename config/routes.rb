Rails.application.routes.draw do
  get 'books/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books, only: :index
end
