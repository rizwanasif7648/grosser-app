# frozen_string_literal: true

module IncidentsConcerns
  extend ActiveSupport::Concern

  def save_image(params)
    decode_img = Base64.decode64(params[:image])
    path = ENV['IMAGE_PHOTO_PATH']
    Dir.mkdir('public/incidents') unless Dir.exist?('public/incidents')
    Dir.mkdir(path) unless Dir.exist?(path)
    image = "#{path}/#{@current_user.id}.png"
    File.open(image, 'wb') { |f| f.write(decode_img) }

    src_file = File.new(File.join(Rails.root, image))
    @incident.image = src_file
    @incident.save!
    File.delete(image) if File.exist?(image)
  end
end
