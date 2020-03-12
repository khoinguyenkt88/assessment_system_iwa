class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.present? && user.is_a?(Teacher)
      can :manage, User
      can :manage, Test
    end
  end
end
