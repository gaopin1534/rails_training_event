Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.twitter_key, Settings.twitter_secret
  provider :github, Settings.github_key, Settings.github_secret
  on_failure do |env|
    # 認証をキャンセルしたりだとかした場合等に/auth/failureにぶっ飛ばす
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
