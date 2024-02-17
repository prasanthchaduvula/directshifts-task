# frozen_string_literal: true

sam = User.create!(
  first_name: "Sam", last_name: "Smith", email: "sam@example.com", password: "welcome",
  password_confirmation: "welcome"
)

puts "Users Created"

Invitation.create!(email: "john@doe.com", sender: sam,)
Invitation.create!(email: "oliver@example.com", sender: sam)

oliver = User.create!(
  first_name: "Oliver", last_name: "Smith", email: "oliver@example.com", password: "welcome",
  password_confirmation: "welcome"
)

puts "Invited users"
