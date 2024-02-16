# frozen_string_literal: true

class ApplicationController < ActionController::Base
  respond_to :html, :json

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up,
        keys: [:first_name, :last_name])
    end
end
