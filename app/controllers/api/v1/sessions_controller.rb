# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :json

  def create
    user = User.find_for_database_authentication(email: user_params[:email])

    if invalid_password?(user)
      render json: { error: t("invalid_credentials") }, status: :unauthorized
    else
      sign_in(user)
      render json: { notice: t("devise.sessions.signed_in"), auth_token: user.authentication_token, user: }, status: :ok
    end
  end

  def destroy
    sign_out current_user
    reset_session
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def invalid_password?(user)
      user.blank? || !user.valid_password?(user_params[:password])
    end

    def render_invalid_password_error
      render json: { error: I18n.t("sessions.failure.invalid") }, status: :unprocessable_entity
    end
end
