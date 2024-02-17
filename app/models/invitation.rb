# frozen_string_literal: true

class Invitation < ApplicationRecord
  scope :valid_invitations, -> {
    where(expired_at:)
  }

  belongs_to :sender, class_name: "User"

  validates :email, presence: true, format: { with: Devise.email_regexp }

  validates_uniqueness_of :email, on: :create, if: -> { user_invitation_present? }

  after_create_commit :send_invitation_mail

  private

    def send_invitation_mail
      InvitationMailer.with(
        recipient: email,
        sender_name: sender.full_name
      ).invitation_email.deliver_later
    end

    def user_invitation_present?
      Invitation.where(email:).valid_invitations.any?
    end
end
