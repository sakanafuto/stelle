class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def size_range
    1..5.megabytes
  end

  def store_dir
    if Rails.env.test?
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  version :profile do
    process resize_to_fill: [500, 500]
  end

  version :thumb do
    process resize_to_fit: [500, 500]
  end

  version :small do
    process resize_to_fill: [50, 50]
  end

  version :comment do
    process resize_to_fill: [30, 30]
  end
end
