CarrierWave.configure do |config|

# Heroku doesn't like having files written.
  config.cache_dir = "#{Rails.root}/tmp/uploads"
# the configured variables need to be set in Heroku's console app to set the environment variables


  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['s3_access_key_id'],       # required
    :aws_secret_access_key  => ENV['s3_secret_access_key'],       # required
  }
  config.fog_directory  = 'MathWorld'                     # required
end
