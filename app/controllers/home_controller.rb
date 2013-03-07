class HomeController < ApplicationController
  #load_and_authorize_resource
  def index
  #  @products = Product.all  #Find all products
    category = Category.where(:name => 'Processors').first
    @category = Category.all
     #Above ^^ Find categories where the name is "Processor" and collect first object of the array
    @products = category.products

    @products = Product.filter(params[:search], [:title])  #Filter method which in the helpers passes the search and title objects
    @counter = session[:counter]                           #Create a new method counter take passes in the counter object
    @counter.nil? ? @counter = 1 : @counter+=1             #check if the counter is nil and then increments it to the counter and passes
    session[:counter] = @counter                           # it back through.

    @cart = current_cart                                   #Get current cart
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

=begin
The above search method sets a results variable sets it to nil,
the respond_to block is get to format teh results in html.
If @results is zero redirect user back to the root path and display
error message 'No records found' else redirect to @result which will be
the product
=end
