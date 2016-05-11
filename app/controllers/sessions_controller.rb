class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    data.oauth_token] = auth.credentials.token
    data.oauth_token_secret = auth.credentials.secret
    data.uid = auth.uid
    login data
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:oauth_token] = nil
    session[:oauth_token_secret] = nil
    session[:username] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
