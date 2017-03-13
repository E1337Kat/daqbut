CarrierWave.configure do |config|
  if Rails.env.test? or Rails.env.development?
    config.storage = :file
    config.enable_processing = false
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['BUCKETEER_BUCKET_NAME']
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.storage :fog
  end
end
