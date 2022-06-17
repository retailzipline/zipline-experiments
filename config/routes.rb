Rails.application.routes.draw do
  get  '/sso/saml' => 'saml#index', as: 'sso_saml'
  post '/sso/saml/acs' => 'saml#acs', as: 'sso_saml_acs'

  resources :experiments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
