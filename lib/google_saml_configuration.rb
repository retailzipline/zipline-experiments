# Handles the fixed configuration of our Google SAML configuration
# that we use to authenticate Zipline employees against the System
# authentication endpoint.
#
# This depends on the SAML metadata being provided in the secrets file
class GoogleSamlConfiguration
  NAME_FORMAT = 'urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified'.freeze

  class Configuration
    attr_accessor :certificate, :private_key, :sp_entity_id, :metadata
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure(&block)
    yield(config)
  end

  attr_reader :url_base

  def initialize(url_base = '')
    @url_base = url_base

    setup
  end

  def settings
    @settings ||= parser.parse(config.metadata)
  end

  private

  def config
    @config ||= self.class.config
  end

  def parser
    @parser ||= OneLogin::RubySaml::IdpMetadataParser.new
  end

  def setup
    # Fixed settings that we require
    settings.sp_entity_id = config.sp_entity_id
    settings.assertion_consumer_service_url = "#{url_base}/sso/saml/acs"
    settings.assertion_consumer_logout_service_url = "#{url_base}/sso/saml/logout"
    settings.certificate = config.certificate
    settings.private_key = config.private_key

    define_security_settings
    define_attributes_contract
  end

  # Overrides the ruby-saml defaults:
  # https://github.com/onelogin/ruby-saml/blob/master/lib/onelogin/ruby-saml/settings.rb#L146
  def define_security_settings
    settings.security.merge!(
      authn_requests_signed: true,
      logout_requests_signed: true,
      logout_responses_signed: true,
      metadata_signed: true
    )
  end

  def define_attributes_contract
    settings.attributes_index = 1
    settings.attribute_consuming_service.configure do
      service_name "Experiments"
      service_index 1

      [
        { name: 'email', name_format: NAME_FORMAT, friendly_name: 'Email' },
        { name: 'given_name', name_format: NAME_FORMAT, friendly_name: 'Given Name' },
        { name: 'family_name', name_format: NAME_FORMAT, friendly_name: 'Family Name' }
      ].each do |attrs|
        add_attribute(attrs)
      end
    end
  end
end
