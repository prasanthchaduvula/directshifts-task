# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invitation_email
    @recipient = params[:recipient]
    @sender_name = params[:sender_details]
    subject = "You have been invited to DirectShifts"

    mail(to: @recipient, subject:)
  end
end
