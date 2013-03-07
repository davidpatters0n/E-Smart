class Ability
  include CanCan::Ability

  def initialize(user) #Pass in the user
    user ||= User.new # guest user
                      # raise user.role?(:administrator).inspect
    if user.role? :administrator
    #Role is defined in the user model. Checks if the user role is an admin
    #If they are an administrator then they can manage everything and manage users

      can :manage, :all
      can :manage, User

    elsif user.role? :customer
      can :read, :all

      #Else the user is a customer they can only read.

    end
  end
end
