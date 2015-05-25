# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.image_url('missing.jpg')
  end

  process resize_to_fit: [128, 128]

  version :thumb do
    process :resize_to_fit => [28, 28]
  end

  version :front do
    process :resize_to_fit => [48, 48]
  end

   def extension_white_list
     %w(jpg jpeg gif png)
   end

end
