class ImageMutator < ApplicationService
  def initialize(image, options)
    @image = image
    @options = options
  end

  def call
    transformation = @options["transformation"]
    case transformation
      when "rotate"
        return rotate()
      when "resize"
        return resize()
      else
        return false
    end
  end

  def resize
    height = @options["height"].to_f
    width = @options["width"].to_f
    return @image.blob.variant(resize_to_fit: [width, height]).processed.url
  end

  def rotate
    angle = @options["angle"].to_f
    return @image.blob.variant(rotate: [angle]).processed.url
  end
end