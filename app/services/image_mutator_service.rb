class ImageMutatorService < ApplicationService
  def initialize(image, options)
    @image = image
    @options = options
  end

  # more jobs can be added to this class or referenced from other service classes as more image
  # mutation features are built; start by adding the job's method to the switch case in call().
  def call
    if @image.blob.attached?
      transformation = @options[:transformation]
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
    height = @options[:height].to_f
    width = @options[:width].to_f
    download_url = @image.blob.variant(resize_to_fill: [width, height]).processed.url
  end

  def rotate
    angle = @options[:angle].to_f
    download_url = @image.blob.variant(rotate: [angle]).processed.url
  end
end