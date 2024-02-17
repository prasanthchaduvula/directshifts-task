# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    sender { build(:user) }
    email { Faker::Internet.email }
    expired_at { nil }
  end
end
