class AdvertisementsController < ApplicationController
  before_action :set_current_user, only: [:index, :show, :edit, :update, :delete, :destroy]
  before_action :set_authorization_for_admin, only: [:show, :edit, :update, :delete, :destroy]
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @advertisements = Advertisement.all
  end

  def show
    if @current_user.role != 'admin'
      respond_to do |format|
        flash[:info] = 'Access restricted to admin'
        format.html { redirect_to advertisements_path }
        format.json { head :no_content }
      end
    end
  end

  def new
    @advertisement = Advertisement.new
  end

  def edit
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to advertisements_path, notice: 'Advertisement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to advertisements_url, notice: 'Advertisement was successfully destroyed.' }
    end
  end

  def publish
    respond_to do |format|
      if @advertisement.update(state: 'published')
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully published.' }
      else
        format.html { render :show }
      end
    end
  end

  private

  def set_advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def advertisement_params
    params.require(:advertisement).permit(:title, :content, :user_id, :state)
  end

  def set_authorization_for_admin
    if !@current_user
      flash[:info] = "Please login"
      return redirect_to request.referrer || root_path
    end
    if @current_user
      if @current_user.role == "admin"
        return true
      end
    end
  end
end
