class UserSerializer < ActiveModel::Serializer
  self.root = :user

  attributes :id, :name, :email, :auth_token, :role

  def auth_token
    object.user_sessions.last&.token
  end
end
