class CategoriesController < ApplicationController

 before_filter :admin, :only => [ :new, :edit, :create, :destroy, :update]


  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  def show
    @category = Category.find(params[:id]) #Find and display all categories and products related to particular category
    @products = @category.products
  end

  def new
    @category = Category.new #Create a new category and set it to be empty. When the _form.html.erb is being used it will

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end

    def edit
      @category = Category.find(params[:id]) #This finds the category using the .find() and pass the category :id into the
                                             #params allowing us to edit the cateory.
    end

    def create
      @category = Category.new(params[:category]) #Create new category based on parameter passed in `:category'`

      respond_to do |format|
        if @category.save
          #If category infomration is successful then diaplay and output below html notice and redirect back to the category path
          format.html { redirect_to :back, notice: 'Category was successfully created.' }
          format.json { render json: @category, status: :created, location: @category }
        else
          #Else if the category is not save the render 'new' action.
          format.html { render action: "new" }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @category = Category.find(params[:id]) #Find the edited category and pass in Category id.

      respond_to do |format|
        if @category.update_attributes(params[:category])
          #If the updated attributes are successful then output successul notice and render @category path
          format.html { redirect_to @category, notice: 'Category was successfully updated.' }
          format.json { head :no_content }
        else
          #Else continue to call the 'edit' action.
          format.html { render action: "edit" }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy

    @category = Category.find(params[:id]) #Find cateogy id that will be deleted.
    if @category.products.count == 0#Check using .count() to determine if category has products == 0
      @category.destroy   #If no products then delete category
      flash[:success] = 'Category has been deleted.' #Once deleted display flash success message
      redirect_to categories_path
    else  #Else there are products related to category then category will not be deleted and then redirected back to
          #category index path
      flash[:error] = "Category can't be deleted, there are products related to this category"
      redirect_to categories_path
    end
  end
end