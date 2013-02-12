class CartsController < ApplicationController

  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}" #If the cart cannot be found the following message
      redirect_to root_url #then the following message 'invalid cart'
      flash[:error]= 'Invalid cart'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @cart }
      end
    end
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html { redirect_to root_url } # new.html.erb
      format.json { render json: @cart }
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to root_url, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart = current_cart #Get current cart
    @cart.destroy #call destroy method on the current cart
    session[:cart_id] = nil #Ensuring that user is deleting their own cart
    respond_to do |format|
      format.html { redirect_to(root_url,
                                :flash => {:error => 'Your cart is currently empty'}) }
      format.xml { head :ok }
    end
  end
end
