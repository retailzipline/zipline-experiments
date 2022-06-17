class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def authenticate_user
    redirect_to sso_saml_path unless authenticated?
  end

  def authenticated?
    valid_session?
  end

  def valid_session?
    current_user.present?
  end

  def current_user
    if Rails.env.development?
      User.first
    else
      User.find_by(id: session[:current_user_id])
    end
  end
end
