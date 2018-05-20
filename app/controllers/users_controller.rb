class UsersController < ApplicationController
  
  def login
  end
  
  def logout
    session[:user_id] = nil
    flash[:info] = "Vous êtes maintenant déconnecté"
    redirect_to "/users"
  end

  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
    p '#'*30
    p @current_user.name
    
    p '#'*30
    if @current_user
      session[:user_id] = @current_user.id
      p '*'*50
      p session[:user_id]
      flash[:info] = "You are now connected"
      redirect_to "/users"
    else
      session[:user_id] = nil
      flash[:info] = "You are now disconnected"
      redirect_to "/users/login"
    end
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # GET /users/1
  # GET /users/1.json
  def show
    set_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    set_user
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    set_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    set_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
