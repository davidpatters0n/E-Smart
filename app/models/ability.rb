class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
                      # raise user.role?(:administrator).inspect
    if user.role? :administrator

      can :manage, :all
      can :manage, User

    elsif user.role? :customer
      can :read, :all

    end
  end
end
