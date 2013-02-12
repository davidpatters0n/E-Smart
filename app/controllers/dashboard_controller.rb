class DashboardController < ApplicationController

  load_and_authorize_resource :class => DashboardController
 #skip_before_filter :authenticate_user!, :only => :index
  #before_filter :authenticate_user!
  # load_and_authorize_resource :user, :parent => false
#  before_filter :admin_user, :only => [:create, :new, :index, :update]

  def index
    @title = "Dashboard"

  end
  
   def search
    @result = nil

    respond_to do |format|
      format.html do
        if @result.nil?
          redirect_to(:root, :error => 'No records found')
        else
          redirect_to(@result)
        end
      end
      format.js
    end
   end
end 