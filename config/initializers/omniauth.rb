OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_app_id'], ENV['facebook_secret'],
            :scope => 'email,user_birthday,read_stream', :display => 'popup'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
           :scope => "userinfo.email, userinfo.profile", :display => 'popup'
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end


