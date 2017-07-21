Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  #get 'contacts' => 'contacts#new', as: :contacts
  #post 'contacts' => 'contacts#create', as: :create_contacts
  #get 'contacts/sent' => 'contacts#sent', as: :contacts_sent

  #get 'search' => 'search#index', as: :search

  #resources :news, only: [:index, :show]

  root to: 'home#index'

  get '*slug' => 'pages#show'
  resources :pages, only: [:show]
end
