class ApplicationController < ActionController::Base
  protect_from_forgery
=begin
Code on Line 22-28 for current_cart references
Ruby, S. and Thomas, D. (2011) Agile web development with Rails. 4th ed. Raleigh, NC: Pragmatic Bookshelf, p.122.
=end

  # if you want to skip authentication, use:
  # skip_before_filter :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|

=begin
      Rescue_form prevent error from occuring and outputs and redirects you back to the root_path and display
      generated alert message
=end

    redirect_to root_path, :alert => exception.message
  end

  private
  #Putting the below methods in private ensures that they are only accessible for all controllers.

  def current_cart
    Cart.find(session[:cart_id]) #Current cart find current cart_id
  rescue ActiveRecord::RecordNotFound # The resuce method prevents the 'RecordNotFound' error from occurring.
    cart = Cart.create # Raised when Active Record cannot find record by given id or set of ids.
    session[:cart_id] = cart.id #Find the next cart
    cart
  end

=begin
          FILTERS used to manage pages
          Purpose of filters are to run before the controller is loaded.
          If the user does meet the filters then they cannot access this page
=end

  def admin
    unless can? :manage, :all
      #if logged user is not admin display error message and redirect to application INDEX (store_path)
      flash[:error] = "Admin can only do this" #Display error message
      redirect_to root_path #Redirect user to root_path (home page)
    end
  end

  def authenticate
    access_denied unless signed_in? #Authenticate method takes in 'access_denied' method
  end                                #and checks if they are signed_in? if they are not deny access

  def access_denied
    if current_user # If current_user redirect_to root_url./
      redirect_to root_url
      flash[:error] = 'You do not have the privledges'
    end
  end

  def correct_user
    @user = User.find(params[:id]) #Find the correct user by passing in User id
    if can? :manage, :all #If user can :manage, :all then give them access to all users accounts
                          #Allow admin to access everyone account
    else
      @user == current_user #Else if user is the current user and do not have these credentials they are rejected
    end
  end
end
