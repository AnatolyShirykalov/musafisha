Rails.application.routes.draw do

  constraints(state: /#{Visit.aasm.states.map(&:name).join("|")}/) do
    get 'decisions/:user/:state', to: 'decisions#index', as: :decisions
    get 'concerts/:state',        to: 'visits#index', as: :visits
  end

  post 'visits/set'

  resources :concerts, only: %i[index show] do
    resources :audios, only: :create
  end
  resources :halls, only: %i[index show]
  resources :decisions, only: [:show]

  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
  }

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
