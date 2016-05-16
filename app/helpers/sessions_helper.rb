module SessionsHelper
  def login! user
    session[:user_id] = user.id
    if session[:user_id].blank?
      false
    else
      true
    end
  end

  def logged_in?
    true if session[:user_id]
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:uid])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def failure
    redirect_to events_url, alert: "login failure"
  end

  def login_filter
    unless logged_in?
      redirect_to events_path, notice: 'Please login first.'
    end
  end

end
