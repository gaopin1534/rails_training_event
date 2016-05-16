class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @auth = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth.uid)
    if @user
      login! @user
      redirect_to events_path, :notice => "login as " + @user.name
    else
      @user = User.new()
      @user.get_data_from_auth_info @auth
      if @user.save
        login!(@user)
        redirect_to root_path, :notice => "Signed in!"
      else
        raise
        redirect_to root_path, :notice => "failed to logging in"
      end
    end
  end

  def destroy
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :nickname, :description, :uid, :token, :secret, :image)
    end

end
