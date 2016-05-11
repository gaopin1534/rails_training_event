class UsersController < ApplicationController
  def new
    @auth = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth.uid)
    if @user
      data = {uid: @auth.uid, token: @auth.credentials.token, secret: @auth.credentials.secret, name: @auth.extra.access_token.params[:screen_name]}
      redirect_to sessions_create_url(data)

    else
      @user = User.new
    end
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    uploader = ImageUploader.new
    uploader.download! user_params[:image]
    @user.image = uploader
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
