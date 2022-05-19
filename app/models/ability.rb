class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: 'guest')

    can :read, :all

    return unless user.chef?

    can :manage, Recipe, user_id: user.id
    can :manage, Food, user_id: user.id
  end
end
