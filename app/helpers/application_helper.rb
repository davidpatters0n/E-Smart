module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition #Condition is based on the attributes that is passed in and uses a block to evaluate it
      attributes["style"] = "display: none"   #Attributes are set to style the cart in the application layout
    end
    content_tag("div", attributes, &block)   #encase the content and the attributes within a <div>
  end

=begin
The below menu item methods are based for the layout of the dashboard for the admin
=end
  def start_icon_menu
    @icon_menu_column = 0 #icon menu column starts at 0
    "<table class='icon_menu'>".html_safe
    #html_Safe ensures that we ensure the html is rendered from a string and not
    #tp escape the html.
  end

  def icon_menu_item( title, image, url )
    text = ""
    if @icon_menu_column >= 4 #If icon menu is greater than or equal to 4 then end table
      text = "</tr>"
      @icon_menu_column = 0
    end
    if @icon_menu_column == 0 #If icon menu is == 0 then start new tr
      text += "<tr>"
    end
    text += "<td><div class='icon_menu_item' onclick=\"location.href='#{url}';\"><span>#{title}</span>" + image_tag( image ) + "</div></td>"
    #Text creates a new table cell and sets the div class icon_menu_item that is called in the dashboard/index.html.erb. onClick gets the url and,
    #whilst putting the title of the "path title" in a <span></span>
    @icon_menu_column += 1

    text.html_safe
  end

  def end_icon_row_internal
    text = ""
    if @icon_menu_column > 0   #Checks if @icon_menu_column is greater than 0
      while @icon_menu_column < 4 #If greater than  0 whilst it is less than 4 create new table cells and assign a div class
        text += "<td><div class='icon_menu_dummy'></div></td>"
        @icon_menu_column += 1
      end
      text += "</tr>"
    end

    text
  end

  def end_icon_row
    end_icon_row_internal.html_safe
  end

  def end_icon_menu
    (end_icon_row_internal + "</table>").html_safe
    #Providing that the end_icon_row_internal has been evaluated and the table cells have been created correctly
    #then end the row and end the table whilst ensuring the html does not escape.
  end


end
