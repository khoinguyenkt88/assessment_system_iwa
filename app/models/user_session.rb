class UserSession < ApplicationRecord
  LIMIT = 10

  belongs_to :user, required: true

  before_create :generate_token

  after_commit :remove_old_sessions

  private

  def generate_token
    return if token.present?

    loop do
      self.token = Devise.friendly_token
      break token unless UserSession.where(token: token).exists?
    end
  end

  def remove_old_sessions
    sessions = user.user_sessions.order(created_at: :asc)
    size = sessions.size
    sessions.first(size - LIMIT).map(&:delete) if size > LIMIT
  end
end