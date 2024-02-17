# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :sender, class_name: "User"

  validates :email, presence: true, format: { with: Devise.email_regexp }
end
