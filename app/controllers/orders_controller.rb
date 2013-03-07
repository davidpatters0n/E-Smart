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
    @cart = current_cart  #"cart is == current_cart"
    if @cart.line_items.empty? #If the cart does not have any line_items redirect to root_url and display notice
      redirect_to root_url, :notice => "Your cart is empty"
      return
    end

    @order = Order.new    #If the "cart" is not empty then generate a new Order.

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
        #OrderMailerProcess is called and passes in the order
        #and uses the .deliver function that sends the user the email.
        #The OrderMailerProcess is a mailer set in mailers directory. order_process
        #is the function that handles the mailer.
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
    #above find function tries to find whether current_user role is a administrator
    @order = Order.find(params[:id]) #Find order by passing in Order_id into params using find function

    if @order.update_attributes(params[:order]) #Checks if "order" attributes have been updated
      if @order.status == "Approved"  #if statement checks if order status is "Approved"
        @order.save                   #If so then save order
      end
      redirect_to orders_path         #Having done this process redirect to orders path
      flash[:sucess]= 'Order was successfully updated and processed'
      #email the user to tell them the state of their holiday
      OrderConfirmation.order_confirmation(@order).deliver
      #order_confirmation method is handled in the OrderConfirmation_mailer that passes in the order.
    else
      render 'edit'
      #If none of this occurs continue to render edit action
    end
  end

  def destroy
    @order = Order.find(params[:id]) #Finds order by passing in order id.
    @order.destroy  #Call destroy function to destroy order

    respond_to do |format|
      format.html { redirect_to orders_url } #Having destroyed order redirect to order index.
      format.json { head :no_content }
    end
  end
end
