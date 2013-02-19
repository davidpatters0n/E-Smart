class UsersController < ApplicationController

  #Filters
  before_filter :admin_user, :only => [:create, :new, :index, :update]
  before_filter :authenticate, :only => [:edit, :update, :new, :create, :destroy]
  before_filter :correct_user, :only => [:edit, :show]

#  load_and_authorize_resource

  def index
    unless signed_in?
      redirect_to new_user_session_path
    end

    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end


  def show
    @user = User.find(params[:id])
    @users = User.all
    @roles = Role.all

    if can? :manage, :all
      @title = @user.first_name
    else
      @title = "My Account"
    end
  end


  def new
    @user = User.new
    @current_method = "new"

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    @role = Role.all
    @roles = Role.all
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(usermanagement_path) }
      format.xml { head :ok }
    end
  end
end