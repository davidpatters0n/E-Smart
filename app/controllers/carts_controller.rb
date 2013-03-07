class CartsController < ApplicationController

  def destroy
    @cart = current_cart #Get current cart
    @cart.destroy #call destroy method on the current cart
    session[:cart_id] = nil #Ensuring that user is deleting their own cart
    respond_to do |format|
      format.html { redirect_to(root_url,
                                :flash => {:error => 'Your cart is currently empty'}) }
      #Redirect user to root_path and display error message notifying them that their cart is empty.
    end
  end
end
