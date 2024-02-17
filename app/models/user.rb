# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :invitations, foreign_key: "sender_id", dependent: :destroy

  validates :first_name, :last_name,
    presence: true,
    format: { with: /\A[a-zA-Z\s]+\z/ },
    length: { maximum: 20 }

  before_save :ensure_authentication_token_is_present

  after_create :verify_invitation

  def full_name
    "#{first_name} #{last_name}"
  end

  private

    def ensure_authentication_token_is_present
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end

    def verify_invitation
      invitation = Invitation.find_by_email(email)
      return unless invitation

      invitation.update(expired_at: Time.zone.now)
    end
end
