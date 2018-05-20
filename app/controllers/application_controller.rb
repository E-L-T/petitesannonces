class ApplicationController < ActionController::Base
  
  private

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def set_authorization
    if !@current_user
      flash[:info] = "Please login"
      return redirect_to request.referrer || root_path
    end
    if @current_user
      if @current_user.role == "admin"
        return true
      end
      if @current_user.id != @user.id
        flash[:info] = "Forbidden access"
        return redirect_to request.referrer || root_path
      end
    end
  end
end
