class UsersController < ApplicationController
  def new
    @auth = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth.uid)
    if @user
      redirect_to create_sessions_url(uid: @auth.uid, token: @auth.credentials.token, secret: @auth.credentials.secret, name: @auth.extra.access_token.params[:screen_name])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to root_url, :notice => "Signed in!"
    else
      render :new
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
