class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    redirect_to events_path, :notice => "Signed out!"
  end

end
