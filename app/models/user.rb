class User < ActiveRecord::Base

  ###############
  # Associations#
  ###############
  has_and_belongs_to_many :roles
  has_many :role_users
  has_many :orders


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Mass assignment
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :role_ids

  #role? that is used throughout the application and mainly used in the
  #ability.rb model passes in the model returns teh role and finds it by the name
  #Converts it to a string camel cases it.
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
