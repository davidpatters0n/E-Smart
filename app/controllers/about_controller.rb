class AboutController < ApplicationController
  def index
    @cart = current_cart #Get current cart
  end
end
