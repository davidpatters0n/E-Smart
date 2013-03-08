class ProductsController < ApplicationController
=begin
The following before_filter that was set in the application_controller is applied in the products_controller
To prevent normal users and non-registered users from viewing the back core index and CRUD [Create, Read, Update, Delete]
pages of the products.

=end
  before_filter :admin, :only => [:new, :edit, :create, :destroy, :update]

=begin
A vital principle that Ruby on Rails incoporates is Convetnion Over Configuration. It
can be seen in alot the controllers that the methods are set up by default which makes it
easier for the developer to rapidly construct CRUD applications. Although these methods can be altered
to whaterver is required.

=end


  def index

   # @category = Category.all #Get all categories
    @products = Product.filter(params[:search], [:title])

=begin
  Filter out the product search based on the title inputted into the params.
=end
    # @products = Product.search(params[:search])
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end


  def show
    @product = Product.find(params[:id])
    @cart = current_cart #Get current cart


    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new #Create a new empty class product

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end


  def edit
    @product = Product.find(params[:id])
  end


  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to @product
    else
      render :action => 'new'
    end
  end


  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id]) #Get product id that is to be deleted.

    if @product.line_items.count == 0 #Check if product has line items that are == 0
      @product.destroy #If product does not have any line items delete product
      flash[:success] = 'Product successfully deleted'
      redirect_to products_path
    else #If product has line_items display the below flash error and redirect back to product index page.
      flash[:error] = 'Prodcut is attached to order and cannot be deleted'
    end
  end
end
