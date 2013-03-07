# == Schema Information
#
# Table name: role_users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoleUser < ActiveRecord::Base
  # attr_accessible :title, :body

  ###############
  # Associations#
  ###############
  belongs_to :user
  belongs_to :role

end
