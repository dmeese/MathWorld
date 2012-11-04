CarrierWave.configure do |config|

# Heroku doesn't like having files written.
  config.cache_dir = "#{Rails.root}/tmp/uploads"
# the configured variables need to be set in Heroku's console app to set the environment variables


  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],       # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],       # required
  }
  config.fog_directory  = 'MathWorld'                     # required
end
