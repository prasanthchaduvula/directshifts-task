# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def invitation_email
    InvitationMailer.with(invitation: Invitation.last).invitation_email
  end
end
