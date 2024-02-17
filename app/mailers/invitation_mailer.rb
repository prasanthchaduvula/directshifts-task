# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invitation_email
    @invitation = params[:invitation]
    subject = "You have been invited to DirectShifts"

    mail(to: @invitation.email, subject:)
  end
end
