class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_authorization_for_current_user_and_admin, only: [:show, :edit, :update, :delete, :destroy]

  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "You are now unlogged"
    redirect_to users_path
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:success] = "You are now logged"
      redirect_to users_path
    else
      session[:user_id] = nil
      flash[:error] = "You are not logged"
      redirect_to users_login_path
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
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to '/users'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to @user
    else
      render :edit
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
    flash[:success] = 'User was successfully destroyed.'
    redirect_to users_url
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
