class ImageHandler
  def initialize(blob, image)
    @blob = blob
    @image = image
  end

  def save_blob
    @image.blob.attach(@blob)
    @image.update(status: 'complete')
  end
end