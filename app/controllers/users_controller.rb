class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  #before_filter :authenticate_user!
#  before_filter :admin_user, :only => [:create, :new, :index, :update]
 # before_filter :authenticate, :only => [:edit, :update, :show, :new, :create, :destroy]
# before_filter :correct_user, :only => [:edit, :show]
  before_filter :admin_user, :only => [:create, :new, :index, :update]
  before_filter :authenticate, :only => [:edit, :update, :show, :new, :create, :destroy]
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

    if current_user.role? :administrator
      @title = @user.first_name
    else
      @title = "My Account"
    end
  end


  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @current_method = "new"

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @role = Role.all
    @roles = Role.all
  end

  # POST /users
  # POST /users.xml
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

  # PUT /users/1
  # PUT /users/1.xml
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

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user.role? :administrator
      #Allow admin to access everyone account
    else
      access_denied unless current_user?(@user)
    end
  end

  def current_user?(user)
    user == current_user
  end

  def admin_user
    redirect_to dashboard_path, :notice => "You must be an admin to do that!" unless current_user.role? :administrator
  end

end