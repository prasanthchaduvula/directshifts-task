# frozen_string_literal: true

json.invitations @invitations do |invitation|
  json.id invitation.id
  json.email invitation.email
  json.expired_at invitation.expired_at
  json.sender_name invitation.sender.full_name
end
