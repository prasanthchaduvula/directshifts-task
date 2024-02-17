# frozen_string_literal: true

require "test_helper"

class InvitationMailerTest < ActionMailer::TestCase
  test "invitation_email" do
    invitation = create(:invitation)
    email = InvitationMailer.with(invitation:).invitation_email
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal ["from@example.com"], email.from
    assert_equal [invitation.email], email.to
    assert_equal "You have been invited to DirectShifts", email.subject
  end
end
