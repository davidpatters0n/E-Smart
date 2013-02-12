class ProductsController < ApplicationController

  before_filter :admin_user, :only => [:create, :new, :index, :update]



  def index
 # @products = Product.all
    @products = Product.filter(params[:search], [:title])
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
    @product = Product.new

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
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def admin_user
    redirect_to root_url => "You must be an admin to do that!" unless current_user.role? :administrator
  end
end
