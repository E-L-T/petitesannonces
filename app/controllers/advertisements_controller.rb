class AdvertisementsController < ApplicationController
  before_action :set_current_user, only: [:index, :show, :edit, :update, :delete, :destroy]
  before_action :set_authorization_for_admin, only: [:edit, :update, :delete, :destroy]
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy, :publish]
  before_action :set_authorization_for_admin_when_ad_state_is_waiting, only: :show

  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisement_author = User.find(@advertisement.user_id).name
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
        flash[:success] = 'Advertisement was successfully created.'
        format.html { redirect_to advertisements_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        flash[:success] = 'Advertisement was successfully updated.'
        format.html { redirect_to @advertisement }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @advertisement.destroy
    respond_to do |format|
      flash[:success] = 'Advertisement was successfully destroyed.'
      format.html { redirect_to advertisements_url }
    end
  end

  def publish
    respond_to do |format|
      if @advertisement.update(state: 'published')
        flash[:success] = 'Advertisement was successfully published.'
        format.html { redirect_to @advertisement }
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
    params.require(:advertisement).permit(:title, :content, :user_id, :state, :price)
  end

  def set_authorization_for_admin
    return false if redirect_if_not_logged
    redirect_to_index_if_not_admin
  end

  def set_authorization_for_admin_when_ad_state_is_waiting
    if !@current_user.try(:admin?) && @advertisement.state == 'waiting'
      respond_to do |format|
        flash[:error] = 'Access restricted to admin'
        format.html { redirect_to advertisements_path }
      end
    end
  end

  def redirect_if_not_logged
    if !@current_user
      flash[:info] = "Please login"
      return redirect_to request.referrer || root_path
    end
  end

  def redirect_to_index_if_not_admin
    if !@current_user.try(:admin?)
      respond_to do |format|
        flash[:error] = 'Access restricted to admin'
        format.html { redirect_to advertisements_path }
      end
    end
  end
end
