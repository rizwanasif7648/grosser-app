require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV.fetch('AWS_ACCESS_KEY_ID', ''),                        # required
      :aws_secret_access_key  => ENV.fetch('AWS_SECRET_ACCESS_KEY', ''),                        # required
      :region                 => ENV.fetch('AWS_REGION', '')
  }
  config.fog_directory  = ENV.fetch('AWS_BUCKET', '')                     # required
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end