# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :sender, class_name: "User"

  validates :email, presence: true, format: { with: Devise.email_regexp }

  after_create_commit :send_invitation_mail

  private

    def send_invitation_mail
      InvitationMailer.with(invitation: self).invitation_email.deliver_later
    end
end
