class UsermanagementController < ApplicationController
  #before_filter :authenticate_user!
  
  load_and_authorize_resource :class => self.class
 #Loads the reosurce into an instance variable and authorises it automatically for that particular controller.
  def index

    @title = "User Management"
    @users = User.all
    authorize! :manage, (@users.first || User)
    #Checks if the user can manage the user. If not then they cannot access this page.
  end
end