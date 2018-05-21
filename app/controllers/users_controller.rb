class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:index, :show, :edit, :update, :delete, :destroy]
  before_action :set_authorization_for_current_user_and_admin, only: [:show, :edit, :update, :delete, :destroy]

  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "You are now unlogged"
    redirect_to "/users"
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:success] = "You are now logged"
      redirect_to "/users"
    else
      session[:user_id] = nil
      flash[:error] = "You are not logged"
      redirect_to "/users/login"
    end
  end
  
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to '/users' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    if @current_user.role != 'admin'
      @current_user = nil
      session[:user_id] = nil
    else
      @current_user = nil
    end
    respond_to do |format|
      flash[:success] = 'User was successfully destroyed.'
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password)
  end

  def set_user
    if params[:id]
      @user = User.find(params[:id])
    end
  end

  def set_authorization_for_current_user_and_admin
    if !@current_user
      flash[:info] = "Please login"
      return redirect_to request.referrer || root_path
    end
    if @current_user
      if @current_user.role == "admin"
        return true
      end
      if @current_user.id != @user.id
        flash[:error] = "Forbidden access"
        return redirect_to request.referrer || root_path
      end
    end
  end
end
