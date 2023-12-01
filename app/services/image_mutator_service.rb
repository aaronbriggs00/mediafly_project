class ImageMutatorService < ApplicationService
  def initialize(image, options)
    @image = image
    @options = options
  end

  def call
    binding.pry
    if @image.blob.url
      transformation = @options["transformation"]
      case transformation
        when "rotate"
          return rotate()
        when "resize"
          return resize()
        else
          return false
      end
    else
      nil
    end
  end

  def resize
    Rails.cache.fetch([@image, :resize], expires_in: 1.hour) do
      height = @options["height"].to_f
      width = @options["width"].to_f
      download_url = @image.blob.variant(resize_to_fit: [width, height]).processed.url
    end
  end

  def rotate
    Rails.cache.fetch([@image, :rotate], expires_in: 1.hour) do
      angle = @options["angle"].to_f
      download_url = @image.blob.variant(rotate: [angle]).processed.url
    end
  end
end