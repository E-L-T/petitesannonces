class ApplicationController < ActionController::Base
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: :index

  private

  def set_user
    if params[:id]
      @user = User.find(params[:id])
    end
  end

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
