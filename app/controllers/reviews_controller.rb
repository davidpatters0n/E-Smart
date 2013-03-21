class ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id]) #Find product by product id
    @review = @product.reviews.create(params[:review]) #create review by giving product and pass in :review inside params

   redirect_to @product  #redirect to product
  end


  def destroy
    @product = Product.find(params[:product_id]) #Find product by its id
    @review = @product.reviews.find(params[:id]) #Find product that is associated with review
    @review.destroy  #Destroy review

    redirect_to product  #redirect to root_path after deleting comment

  end
end


