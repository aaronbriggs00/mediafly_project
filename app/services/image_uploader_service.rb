class ImageUploaderService < ApplicationService
  def initialize(blob, image, options)
    @blob = blob
    @image = image
    @options = options
  end

  def call
    begin
      @image.blob.attach(@blob)
      @image.blob.attached? ? @image.update(status: 'complete') : @image.update(status: 'failed')
    rescue
      @image.update(status: 'failed')
    end
  end
end

