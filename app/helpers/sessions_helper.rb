module SessionsHelper
  def login params
    params = params.attributes unless params.kind_of?(Hash)
    session[:oauth_token] = params[:token]
    session[:oauth_token_secret] = params[:secret]
    session[:uid] = params[:uid]
  end

  def logged_in?
    true if session[:oauth_token]
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (uid = session[:uid])
      @current_user ||= User.find_by(uid: uid)
    elsif (uid = cookies.signed[:uid])
      user = User.find_by(uid: uid)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def login_filter
    unless logged_in?
      redirect_to root_path, notice: 'you need to login to use this function'
    end
  end

end
