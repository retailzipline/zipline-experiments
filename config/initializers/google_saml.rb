require_dependency 'google_saml_configuration'

GoogleSamlConfiguration.configure do |config|
  app_config = Rails.application.config_for(:google_saml)

  config.certificate = app_config.certificate
  config.metadata = app_config.metadata
  config.private_key = app_config.private_key
  config.sp_entity_id = app_config.sp_entity_id
end
