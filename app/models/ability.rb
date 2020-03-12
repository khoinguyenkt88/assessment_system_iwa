class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    p 'KKKKKK', user

    if user.present? && user.is_a?(Teacher)
      can %i[manage], User
    end
  end
end
