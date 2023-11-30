class ImageUploader
  def initialize(blob, image, options)
    @blob = blob
    @image = image
    @options = options
  end

  def save_blob
    if @image.blob.attach(@blob)
      @image.update(status: 'complete')
    else
      @image.update(status: 'failed')
    end
  end
end