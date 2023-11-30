class ImageUploader < ApplicationService
  def initialize(blob, image, options)
    @blob = blob
    @image = image
    @options = options
  end

  def call
    @image.blob.attach(@blob)
    if @image.blob.attached?
      @image.update(status: 'complete')
    else
      @image.update(status: 'failed')
    end
  end
end