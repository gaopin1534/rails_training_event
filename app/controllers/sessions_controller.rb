class SessionsController < ApplicationController

  def create

    if login! params
      redirect_to events_path, :notice => "login as " + params["name"]
    else
      redirect_to events_path, :notice => "login failure"
    end
  end

  def destroy
    session[:oauth_token] = nil
    session[:oauth_token_secret] = nil
    session[:uid] = nil
    session[:user_id] = nil
    redirect_to events_path, :notice => "Signed out!"
  end

end
