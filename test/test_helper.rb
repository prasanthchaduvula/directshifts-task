# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods

  def headers(user, options = {})
    {
      "X-Auth-Token" => user.authentication_token,
      "X-Auth-Email" => user.email
    }.merge(options)
  end
end
