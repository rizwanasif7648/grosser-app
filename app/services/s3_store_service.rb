# frozen_string_literal: true

class S3StoreService
  BUCKET = ENV['BUCKET']

  def initialize(file)
    @file = file
    @s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    @bucket = @s3.bucket(ENV['AWS_BUCKET'])
  end

  def store(key)
    @obj = @bucket.object(key + '/' + filename)
    @obj.upload_file(@file, { acl: 'private' })
  end

  def url
    @obj.public_url.to_s
  end

  private

  def filename
    @filename ||= @file.to_s.split('/').last
  end
end
