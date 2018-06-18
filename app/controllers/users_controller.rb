class UsersController < ApplicationController
  before_action :set_user

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
      redirect_to users_path
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
    if @user.destroy
      flash[:success] = 'User was successfully destroyed.'
    end  
    redirect_to users_path
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
end
