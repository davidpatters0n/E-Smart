module FilterScope 
  def self.included(base) #Pass in the base class
    base.class_eval do #class_eval evaluates the block.
      scope :filter, lambda { |query, attributes| #Take in the attributes that are being searched
        return if query.blank? #Checks if the query is blank

        collection = self

        attributes = collection.new.attributes unless attributes
        query.split(/\s/).each do |phrase| #Split the query and loop through it
          conditions = [""]
          attributes.each do |attribute| #Loop the attributes
            conditions[0] += attribute.to_s + " LIKE ? OR "
            conditions.push "%#{phrase}%" #Push the conditions to the phrase instance.
          end
          conditions[0] = conditions[0].sub(/ OR $/,"")
          collection = collection.where(conditions)  #The query checks whether the collection of the query meets the conditions
        end

        collection
      }
    end
  end
end