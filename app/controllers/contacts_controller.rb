class ContactUs::ContactsController < ApplicationController

  def create
    @contact = ContactUs::Contact.new(params[:contact_us_contact])
    #Contact object takes in the generated ContactUs model and creats a  new Contact object
    #by passing in the parameters contact_us_contact.


    if @contact.save
      redirect_to('/', :notice => t('contact_us.notices.success'))
      #If the contact is saved provided success notification if not flash an error
    else
      flash[:error] = t('contact_us.notices.error')
      render_new_page
    end
  end

  def new
    @contact = ContactUs::Contact.new

    render_new_page

  end

  protected

  #This is a protected method should I want to generate my Contact form using formtastic or
  # simple_gem
    def render_new_page
      case ContactUs.form_gem
      when 'formtastic'  then render 'new_formtastic'
      when 'simple_form' then render 'new_simple_form'
      else
        render 'new'
      end
    end

end
