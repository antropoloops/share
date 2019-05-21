# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data
Shrine.plugin :store_dimensions
Shrine.plugin :restore_cached_data
# Shrine.plugin :pretty_location
Shrine.plugin :backgrounding

s3_config = {
  bucket: ENV['S3_BUCKET'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION'],
  public: true,
  upload_options: {
    acl: 'public-read',
    cache_control: 'max-age=31536000'
  }
}

# MinIO specific configuration
if Rails.env.development? && ENV['S3_ENDPOINT'].present?
  s3_config[:public] = false
  s3_config[:force_path_style] = true
  s3_config[:endpoint] = ENV['S3_ENDPOINT']
end

if Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  Shrine.plugin :logging
  Shrine.storages = {
    # cache: Shrine::Storage::FileSystem.new('tmp', prefix: 'uploads/cache'),
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_config),
    store: Shrine::Storage::S3.new(prefix: 'files', **s3_config)
  }
end
