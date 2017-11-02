Rails.application.routes.draw do

  resources :forms
  resources :destinations
  resources :comments
  resources :guidebooks
  root 'welcome#index'

  mount MailyHerald::Webui::Engine => "/maily_webui"

  resources :backgrounds
  resources :collaborators
  resources :customers
  resources :tour_pictures
  resources :bank_accounts do
    member do
      get 'activate', to: 'bank_accounts#activate', as: 'activate'
    end
  end
  resources :marketplaces do
    member do
      get 'activate', to: 'marketplaces#activate', as: 'activate'
      get 'update_account', to: 'marketplaces#update_account', as: 'update_account'
      get 'request_external_payment_type_auth', to: 'marketplaces#request_external_payment_type_auth', as: 'request_external_payment_type_auth'
      get 'redirect', to: 'marketplaces#redirect', as: 'redirect'
    end
  end
  resources :translations

  resources :packages

  get 'tags/index'
  get 'languages/index'
  #get 'wheres/index'

  get 'contacts/index'
  post 'contacts/send_form'
  post 'contacts/send_message'

  get 'welcome/organizer', to: 'welcome#organizer', as: 'organizer_welcome'
  get 'welcome/user', to: 'welcome#user', as: 'user_welcome'

  resources :orders

  resources :wheres

  post 'webhook', to: 'orders#webhook'
  post 'webhook_external_payment', to: 'orders#webhook_external_payment'
  post 'redirect_external', to: 'orders#redirect_external'
  get 'new_webhook', to: 'orders#new_webhook'
  get 'redirect', to: 'marketplaces#redirect'

  get 'flights/nearest_airports', to: 'flights#nearest_airports'

  get 'organizers/create_from_auth', to: 'organizers#create_from_auth', as: 'create_from_auth'
  get 'organizers/invite', to: 'organizers#invite', as: 'invite'
  get 'organizers/accept_invite/(:id)/(:token)', to: 'organizers#accept_invite', as: 'accept_invite'
  post 'organizers/send_invite', to: 'organizers#send_invite', as: 'send_invite'

  resources :organizers do
    member do
      get 'manage/(:tour)', to: 'organizers#manage', as: 'manage'
      get 'marketplace', to: 'organizers#marketplace', as: 'marketplace'
      get 'transfer', to: 'organizers#transfer', as: 'transfer'
      post 'transfer_funds', to: 'organizers#transfer_funds', as: 'transfer_funds'
      get 'tos_acceptance', to: 'organizers#tos_acceptance', as: 'tos_acceptance'
      post 'tos_acceptance_confirm', to: 'organizers#tos_acceptance_confirm', as: 'tos_acceptance_confirm'
      get 'dashboard', to: 'organizers#dashboard', as: 'dashboard'
      get 'account', to: 'organizers#account', as: 'account'
      get 'account_edit', to: 'organizers#account_edit', as: 'account_edit'
      get 'profile_edit', to: 'organizers#profile_edit', as: 'profile_edit'
      get 'bank_account_edit', to: 'organizers#bank_account_edit', as: 'bank_account_edit'
      get 'account_status', to: 'organizers#account_status', as: 'account_status'
      get 'confirm_account', to: 'organizers#confirm_account', as: 'confirm_account'
      get 'guided_tour', to: 'organizers#guided_tour', as: 'guided_tour'
      get 'schedule', to: 'organizers#schedule', as: 'schedule'
      get 'clients', to: 'organizers#clients', as: 'clients'
      get 'external_events', to: 'organizers#external_events', as: 'external_events'
      post 'import_events', to: 'organizers#import_events', as: 'import_events'
      get 'edit_guided_tour/(:tour)', to: 'organizers#edit_guided_tour', as: 'edit_guided_tour'
    end
  end

  resources :tours do
    member do
      get 'confirm/(:packagename)', to: 'tours#confirm', as: 'confirm'
      get 'copy_tour', to: 'tours#copy_tour', as: 'copy_tour'
      post 'confirm_presence'
      get 'confirm_presence_alt'
      post 'unconfirm_presence'
    end
  end

  resources :guidebooks do
    member do
      get 'confirm/(:packagename)', to: 'guidebooks#confirm', as: 'confirm'
      post 'confirm_presence'
      get 'confirm_presence_alt'
      post 'unconfirm_presence'
    end
  end

  post 'subscribers/create'

  devise_for :users, :controllers => {
      :registrations => "users/registrations",
      :omniauth_callbacks => "users/omniauth_callbacks",
      :sessions => "users/sessions"
  }

  resources :users do
    member do
      get 'follow', to: 'users#follow'
      get 'unfollow', to: 'users#unfollow'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  get 'logos' => 'welcome#logos'
  get 'manifest' => 'welcome#manifest'
  get 'how_it_works' => 'welcome#how_it_works'
  get 'privacy' => 'welcome#privacy'
  get 'defs' => 'welcome#defs'
  get 'faq' => 'welcome#faq'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
