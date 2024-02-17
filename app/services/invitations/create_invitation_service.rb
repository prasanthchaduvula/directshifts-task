# frozen_string_literal: true

module Invitations
  class CreateInvitationService
    attr_reader :params, :current_user
    attr_accessor :invitation

    def initialize(params, current_user)
      @params = params
      @current_user = current_user
      @invitation = Invitation.new(params)
    end

    def process
      set_sender
      invitation.save!
    end

    private

      def set_sender
        @invitation.sender = current_user
      end
  end
end
