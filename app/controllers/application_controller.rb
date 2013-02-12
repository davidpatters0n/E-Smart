class ApplicationController < ActionController::Base
  protect_from_forgery
 #  before_filter :authenticate_user!
#   load_and_authorize_resource
  private
  def current_cart
    Cart.find(session[:cart_id]) #Current cart find current cart_id
  rescue ActiveRecord::RecordNotFound # The resuce method prevents the 'RecordNotFound' error from occurring.
    cart = Cart.create # Raised when Active Record cannot find record by given id or set of ids.
    session[:cart_id] = cart.id #Find the next cart
    cart
  end


  def authenticate
    access_denied unless signed_in?
  end

  def access_denied
    if current_user
      redirect_to root_url
      flash[:error] = 'You do not have the privledges'
    else
      redirect_to login_path
      flash[:notice] = 'Please login first'
    end
  end

  def admin_user
    redirect_to root_url
    flash[:error] = "You must be an admin to do that!" unless current_user.role? :administrator
  end


  def correct_user
    @user = current_user
    @user = User.find(params[:id])
    if current_user.role? :administrator
      #Allow admin to access everyone account
    else
      access_denied unless current_user?(@user)
    end
  end


end
