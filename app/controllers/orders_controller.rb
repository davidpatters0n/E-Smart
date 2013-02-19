class OrdersController < ApplicationController

  before_filter :admin, :only => [:index, :edit, :destroy, :update]

  def index
    @users = User.all #Get all users
    @orders = Order.all # Get all orders
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_url, :notice => "Your cart is empty"
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def edit
    @order = Order.find(params[:id]) #Find order that is to be edited and then edit the STATUS of the order
  end

  def create
   # @user = User.new(params[:user])
    @order = Order.new(params[:order]) #Create new order based on the 'new' action and pass in order object.
    @order.add_line_items_from_cart(current_cart) #Add the line_items from the cart to the @order.

    respond_to do |format|
      if @order.save #Begin to save order
        OrderMailerProcess.order_process(@order).deliver
        Cart.destroy(session[:cart_id]) #If the order is saved destroy the current session of the cart.
        session[:cart_id] = nil #Cart_id now becomes nil
        format.html { redirect_to(root_url, :notice => #Format into ht
            'Thank you for your order you will recieve an email shortly.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    admin = User.find(current_user.role? :administrator)
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      if @order.status == "Approved"
        @order.save
      end
      redirect_to orders_path
      flash[:sucess]= 'Order was successfully update'
      #email the user to tell them the state of their holiday
      OrderConfirmation.order_confirmation(@order).deliver
    else
      render 'edit'

    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
