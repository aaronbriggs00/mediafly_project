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
    cache_key = [@image, @options[:transformation], @options[:height], @options[:width]]
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      height = @options[:height].to_f
      width = @options[:width].to_f
      download_url = @image.blob.variant(resize_to_fill: [width, height]).processed.url
    end
  end

  def rotate
    cache_key = [@image, @options[:transformation], @options[:angle]]
    Rails.cache.fetch([@image, :rotate], expires_in: 5.minutes) do
      angle = @options[:angle].to_f
      download_url = @image.blob.variant(rotate: [angle]).processed.url
    end
  end
end