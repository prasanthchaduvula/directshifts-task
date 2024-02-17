# frozen_string_literal: true

class Api::V1::InvitationsController < Api::V1::BaseController
  before_action :invalid_invitation!, only: [:create]

  def index
    @invitations = Invitation.includes(:sender).all
  end

  def create
    Invitations::CreateInvitationService.new(invitation_params, current_user).process
    render json: { notice: t("invitation.create.success.message") }, status: :ok
  end

  private

    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def invalid_invitation!
      if User.exists?(email: invitation_params[:email])
        render json: { message: t("invitation.exists.user.message") }, status: 409
      end

      if Invitation.exists?(email: invitation_params[:email])
        render json: { message: t("invitation.exists.invitation.message") }, status: 409
      end
    end
end
