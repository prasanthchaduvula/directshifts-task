# frozen_string_literal: true

require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "create - non logged in user" do
    post api_v1_invitations_path, as: :json
    assert_response :unauthorized
  end

  test "create - happy path" do
    user = create(:user)
    invitee_email = Faker::Internet.email
    headers = headers(user)

    assert_emails 1 do
      assert_difference -> { Invitation.count } => 1 do
        post api_v1_invitations_path, as: :json, headers:, params: {
          invitation: { email: invitee_email }
        }
      end
    end
    assert_response :success
    invitation = Invitation.last
    assert_equal user.id, invitation.sender_id
    assert_equal invitee_email, invitation.email
    assert_nil invitation.expired_at

    last_email = ActionMailer::Base.deliveries.last
    assert_equal ["from@example.com"], last_email.from
    assert_equal [invitee_email], last_email.to
    assert_equal "You have been invited to DirectShifts", last_email.subject
  end

  test "create - user already exists with email" do
    invitee_email = Faker::Internet.email
    user = create(:user, email: invitee_email)
    headers = headers(user)

    assert_no_difference -> { Invitation.count } do
      post api_v1_invitations_path, as: :json, headers:, params: {
        invitation: { email: invitee_email }
      }
    end
    assert_response 409
    assert_equal "User already exists", JSON.parse(response.body)["message"]
  end

  test "create - invitation already exists with email" do
    invitee_email = Faker::Internet.email
    user = create(:user)
    create(:invitation, email: invitee_email)
    headers = headers(user)

    assert_no_difference -> { Invitation.count } do
      post api_v1_invitations_path, as: :json, headers:, params: {
        invitation: { email: invitee_email }
      }
    end
    assert_response 409
    assert_equal "Invitation already exists", JSON.parse(response.body)["message"]
  end
end
