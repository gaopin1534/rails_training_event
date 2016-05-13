class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @auth = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth.uid)
    if @user
      data = {id: @user.id, uid: @auth.uid, token: @auth.credentials.token, secret: @auth.credentials.secret, name: @auth.info.name}
      redirect_to sessions_create_url(data)
    else
      @user = User.new()
      @user.name = @auth.info.name
      @user.uid = @auth.uid
      @user.nickname = @auth.info.nickname
      @user.description = @auth.info.description
      @user.token = @auth.credentials.token
      @user.secret = @auth.credentials.secret
      uploader = ImageUploader.new
      uploader.download! @auth.info.image
      @user.image = uploader
      if @user.save
        login!(@user)
        redirect_to root_path, :notice => "Signed in!"
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
