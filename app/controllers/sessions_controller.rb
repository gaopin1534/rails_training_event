class SessionsController < ApplicationController
  def new
  end

  def create

    # data.oauth_token = auth.credentials.token
    # data.oauth_token_secret = auth.credentials.secret
    # data.uid = auth.uid
    if login! params
      redirect_to root_url, :notice => "login as " + current_user.name
    else
      redirect_to root_url, :notice => "login failure"
    end
  end

  def destroy
    session[:oauth_token] = nil
    session[:oauth_token_secret] = nil
    session[:uid] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
