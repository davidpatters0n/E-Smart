class UsermanagementController < ApplicationController
  #before_filter :authenticate_user!
  
 #load_and_authorize_resource :user, :parent => false
  load_and_authorize_resource :class => self.class
 #load_and_authorize_resource
  def index

    @title = "User Management"
    @users = User.all
#    @roles = Role.all
    authorize! :manage, (@users.first || User)        
  end
end