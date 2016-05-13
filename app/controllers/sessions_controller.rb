class SessionsController < ApplicationController
  def new
  end

  def create

    if login! params
      redirect_to events_path, :notice => "login as " + current_user.name
    else
      redirect_to events_path, :notice => "login failure"
    end
  end

  def destroy
    session[:oauth_token] = nil
    session[:oauth_token_secret] = nil
    session[:uid] = nil
    redirect_to events_path, :notice => "Signed out!"
  end

end
