module SessionsHelper
  def login! params
    params = params.attributes.with_indifferent_access unless params.kind_of?(Hash)
    session[:oauth_token] = params[:token]
    session[:oauth_token_secret] = params[:secret]
    session[:uid] = params[:uid]
    session[:user_id] = current_user.id
    if session[:oauth_token].blank? | session[:oauth_token_secret].blank? | session[:uid].blank?
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

  def login_filter
    unless logged_in?
      redirect_to events_path, notice: 'Please login first.'
    end
  end

end
