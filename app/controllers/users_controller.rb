class UsersController < ApplicationController
  # before_action :login_filter, only: [:show]
  # def new
  #   @auth = request.env['omniauth.auth']
  #   @user = User.find_by(uid: @auth.uid)
  #   if @user
  #     data = {uid: @auth.uid, token: @auth.credentials.token, secret: @auth.credentials.secret, name: @auth.extra.access_token.params[:screen_name]}
  #     redirect_to sessions_create_url(data)
  #
  #   else
  #     @user = User.new
  #   end
  # end

  def show
    @user = User.find(params[:id])
  end

  def create
    @auth = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth.uid)
    if @user
      data = {uid: @auth.uid, token: @auth.credentials.token, secret: @auth.credentials.secret, name: @auth.extra.access_token.params[:screen_name]}
      redirect_to sessions_create_url(data)
    else
      @user = User.new()
      @user.name = @auth.extra.access_token.params[:screen_name]
      @user.uid = @auth.uid
      @user.nickname = @auth.extra.raw_info.name
      @user.description = @auth.extra.raw_info.description
      @user.token = @auth.credentials.token
      @user.secret = @auth.credentials.secret
      uploader = ImageUploader.new
      uploader.download! @auth.extra.raw_info.profile_image_url
      @user.image = uploader
      if @user.save
        login!(@user)
        redirect_to root_path, :notice => "Signed in!"
      end
    end
  end
  # def create
  #   @user = User.new(user_params)
  #   uploader = ImageUploader.new
  #   uploader.download! user_params[:image]
  #   @user.image = uploader
  #   if @user.save
  #     login(@user)
  #     redirect_to root_url, :notice => "Signed in!"
  #   else
  #     render :new
  #   end
  # end

  def destroy
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :nickname, :description, :uid, :token, :secret, :image)
    end

end
