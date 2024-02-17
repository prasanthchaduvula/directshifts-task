# frozen_string_literal: true

class Api::V1::InvitationsController < Api::V1::BaseController
  def index
    @invitations = Invitation.includes(:sender).all
  end

  def create
    Invitations::CreateInvitationService.new(invitation_params, current_user).process
    render json: { notice: I18n.t("invitation.create.success.message") }, status: :created
  end

  private

    def invitation_params
      params.require(:invitation).permit(:email)
    end
end
