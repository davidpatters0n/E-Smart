class RoleUsersController < ApplicationController
  # GET /role_users
  # GET /role_users.json
  def index
    @role_users = RoleUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @role_users }
    end
  end

  # GET /role_users/1
  # GET /role_users/1.json
  def show
    @role_user = RoleUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role_user }
    end
  end

  # GET /role_users/new
  # GET /role_users/new.json
  def new
    @role_user = RoleUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role_user }
    end
  end

  # GET /role_users/1/edit
  def edit
    @role_user = RoleUser.find(params[:id])
  end

  # POST /role_users
  # POST /role_users.json
  def create
    @role_user = RoleUser.new(params[:role_user])

    respond_to do |format|
      if @role_user.save
        format.html { redirect_to @role_user, notice: 'Role user was successfully created.' }
        format.json { render json: @role_user, status: :created, location: @role_user }
      else
        format.html { render action: "new" }
        format.json { render json: @role_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /role_users/1
  # PUT /role_users/1.json
  def update
    @role_user = RoleUser.find(params[:id])

    respond_to do |format|
      if @role_user.update_attributes(params[:role_user])
        format.html { redirect_to @role_user, notice: 'Role user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @role_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_users/1
  # DELETE /role_users/1.json
  def destroy
    @role_user = RoleUser.find(params[:id])
    @role_user.destroy

    respond_to do |format|
      format.html { redirect_to role_users_url }
      format.json { head :no_content }
    end
  end
end
