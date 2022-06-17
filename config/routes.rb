Rails.application.routes.draw do
  get  '/sso/saml' => 'saml#index', as: 'sso_saml'
  post '/sso/saml/acs' => 'saml#acs', as: 'sso_saml_acs'

  resources :experiments

  get '/exp/:id' => 'experiments#serve'

  # Defines the root path route ("/")
  root "experiments#index"
end
