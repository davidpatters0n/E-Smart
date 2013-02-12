class LineItemsController < ApplicationController

  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end


  def create
    @cart = current_cart # Get current cart
    product = Product.find(params[:product_id]) #Find proudct id
    @line_item = @cart.line_items.build(:product_id => product.id) #.build function creates a new line item that takes in the
    @line_item = @cart.add_product(product.id) #product_id, and uses the .add function to add it to @line_item
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_url }
        format.xml { render :xml => @line_item,
                            :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @line_item.errors,
                            :status => :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end
end
