# frozen_string_literal: true

require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  def setup
    @invitation = build(:invitation)
  end

  def test_invitation_should_be_valid
    assert @invitation.valid?
  end

  def test_email_cannot_be_blank
    @invitation.email = nil
    assert_not @invitation.valid?
    assert_includes @invitation.errors.full_messages, "Email can't be blank"
  end

  def test_email_format_should_be_valid
    @invitation.email = "invalid_email"
    assert_not @invitation.valid?
    assert_includes @invitation.errors.full_messages, "Email is invalid"
  end

  def test_invitation_association_with_sender
    assert_respond_to @invitation, :sender
  end

  def test_send_invitation_mail_is_private_method
    assert_not_respond_to @invitation, :send_invitation_mail
  end
end
