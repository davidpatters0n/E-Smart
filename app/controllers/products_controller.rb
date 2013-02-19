class ProductsController < ApplicationController

    before_filter :admin, :only => [:index, :new, :edit, :create, :destroy, :update]


  def index
    #  @products = Product.all
    @category = Category.all
    @products = Product.filter(params[:search], [:title])
    # @products = Product.search(params[:search])
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end


  def show
    @product = Product.find(params[:id])

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
    else
      flash[:error] = 'Prodcut is attached to order and cannot be deleted'
    end
  end
end
