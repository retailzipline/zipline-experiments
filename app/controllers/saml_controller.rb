require_dependency 'google_saml_configuration'

class SamlController < ApplicationController
  # No authentication necessary here
  skip_before_action :verify_authenticity_token, :authenticate_user

  def index
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings), allow_other_host: true)
  end

  def acs
    @saml_response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings)

    if @saml_response.is_valid?
      session.merge!(new_zipline_employee_session(@saml_response))
      redirect_to system_root_path
    else
      Rails.logger.warn("[SAML]") { "Invalid Response Errors - #{@saml_response.errors}" }
      render file: "public/401.html", layout: false, status: status
    end
  end

  private

  def saml_settings
    url_base = [request.protocol, request.host_with_port].join
    GoogleSamlConfiguration.new(url_base).settings
  end

  def session_details_for_user(saml_response)
    user = user_from_response(saml_response)

    {
      current_user_id: user.id,
      expires_at: 12.hours.from_now.to_i
    }
  end

  def user_from_response(saml_response)
    User.find_or_create_by(email: saml_response.nameid) do |user|
      given_name = saml_response.attributes['given_name']
      family_name = saml_response.attributes['family_name']

      user.name = [given_name, family_name].join(' ')
    end
  end
end
