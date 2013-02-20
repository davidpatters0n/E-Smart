class ApplicationController < ActionController::Base
  protect_from_forgery
  #  before_filter :authenticate_user!
  #   load_and_authorize_resource
  #Code below for current_cart references "Agile Web Development (page ....)"

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
          FILTERS
=end

  def admin
    unless can? :manage, :all
      #if logged user is not admin display error message and redirect to application INDEX (store_path)
      flash[:error] = "Admin can only do this"
      redirect_to root_path
    end
  end

  def authenticate
    access_denied unless signed_in?
  end

  def access_denied
    if current_user
      redirect_to root_url
      flash[:error] = 'You do not have the privledges'
    else
      redirect_to root_url
      flash[:error] = 'You do not have the privledges'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if can? :manage, :all
      #Allow admin to access everyone account
    else
      @user == current_user
    end
  end
end
