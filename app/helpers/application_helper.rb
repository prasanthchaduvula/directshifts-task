# frozen_string_literal: true

module ApplicationHelper
  def get_client_props
    {
      user: current_user
    }
  end
end
