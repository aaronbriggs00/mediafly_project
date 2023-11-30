class ImagesController < ApplicationController
  before_action :authenticate_user

  def index
    @images = Image.all
    render json: @images, each_serializer: SimpleImageSerializer
  end

  def show
    @image = Image.find(params[:id])
    render json: @image, serializer: CompleteImageSerializer
  end

  def create
    @image = Image.new(user_id: current_user.id, status: 'processing')

    if @image.valid? && valid_image
      @image.save
      render json: { data: @image }, status: :created
      ## should probably create a job to handle this
      ImageUploader.call(image_params[:blob], @image, {})
      ##
    else  
      render json: { errors: @image.errors.full_messages }, status: :bad_request
    end
  end

  def mutate
    image = Image.find(params[:id])
    download_url = image.fetch_mutation(mutation_params)

    if download_url
      render json: { image_url: download_url }, status: :ok
    else
      render json: { errors: "unprocessable mutations options, please refer to documentation for input" }, status: :bad_request
    end
  end

  private

  def image_params
    params.permit(:blob)
  end

  def mutation_params
    params.require(:options).permit(:transformation, :angle, :height, :width)
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
