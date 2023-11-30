class ImagesController < ApplicationController
  before_action :authenticate_user

  def index
    render json: "image#index"
  end

  def show
    @image = Image.find(params[:id])
    render json: { data: @image, download_url: @image.blob.url }
  end

  def create
    @image = Image.new(user_id: current_user.id, status: 'processing')

    if @image.valid? && valid_image
      @image.save
      render json: { data: [@image, image_params] }, status: :created
      image_uploader = ImageUploader.new(image_params[:blob], @image, {})
      image_uploader.save_blob
    else  
      render json: { errors: @image.errors.full_messages }, status: :bad_request
    end
  end

  private

  def image_params
    params.permit(:blob)    
  end

  def valid_image
    valid_types = ['image/png', 'image/jpeg', 'image/tiff']
    if image_params[:blob].respond_to?(:content_type) && valid_types.include?(image_params[:blob].content_type)
      return true
    else
      @image.errors.add(:blob, "file must be a jpeg, jpg, png, or tiff")
      return false
    end
  end
end
