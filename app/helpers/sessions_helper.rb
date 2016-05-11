module SessionsHelper
  def login params
    session[:oauth_token] = params.token
    session[:oauth_token_secret] = params.secret
    session[:uid] = params.uid
    if params.token.blank? || params.secret.blank?
      false
    else
      true
    end
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

end
