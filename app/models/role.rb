class Role < ActiveRecord::Base
  #Accessible attributes that uses mass-assignemnt so that attributes can be accessed from other models.
  attr_accessible :name

  ###############
  # Associations#
  ###############
  has_and_belongs_to_many :users

end
