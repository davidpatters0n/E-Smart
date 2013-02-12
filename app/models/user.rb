class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_many :role_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :role_ids

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
