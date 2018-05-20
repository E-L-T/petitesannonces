class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:info] = "Vous êtes maintenant déconnecté"
    redirect_to "/users"
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:info] = "You are now connected"
      redirect_to "/users"
    else
      session[:user_id] = nil
      flash[:info] = "You are now disconnected"
      redirect_to "/users/login"
    end
  end
  
  def index
    @users = User.all
  end

  def show
    p '*'*60
    p @current_user.id
    p @user.id
    p @current_user.role
    if @current_user.role == "admin"
      return true
    end
    if @current_user.id != @user.id
      return head :forbidden
    end
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
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      if params[:id]
        @user = User.find(params[:id])
      end
    end

    def user_params
      params.require(:user).permit(:name, :password)
    end
end
