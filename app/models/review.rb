class Review < ActiveRecord::Base
  belongs_to :product
  attr_accessible :author, :content, :rating, :title

  before_save :force_rating

  #Method gets called before every save to database method inside of this class and has access to the variable
  def force_rating #Will not allows the user to enter anything higher or lower than the values set.
     if self.rating > 5 #Can check the value of the rating is greater than 5
       self.rating  = 5 #
     end
    if self.rating < 1
      self.rating = 1
    end
  end
end
