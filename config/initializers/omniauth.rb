Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.twitter_key, Settings.twitter_secret
  provider :github, Settings.github_key, Settings.github_secret
  provider :facebook, Settings.facebook_key, Settings.facebook_secret,
                           image_size: { width: 500, height: 500 },
                           secure_image_url: true,
                           info_fields:"name,email,about,bio",
                           scope:"user_about_me,email"
  on_failure do |env|
    # 認証をキャンセルしたりだとかした場合等に/auth/failureにぶっ飛ばす
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
