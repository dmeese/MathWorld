CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'VALUE_HERE',       # required
    :aws_secret_access_key  => 'VALUE_HERE',       # required
  }
  config.fog_directory  = 'MathWorld'                     # required
end
