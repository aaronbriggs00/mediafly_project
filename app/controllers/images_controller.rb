class ImagesController < ApplicationController
  before_action :authenticate_user

  def index
    render json: "image#index"
  end

  def show
    render json: "image#show"
  end

  def create
    @image = Image.new(image_params)
    @image.user_id = current_user.id
    @image.status = "processing"
    if @image.valid?
      @image.save
      render json: @image, status: :created
    else  
      render json: { errors: @image.errors.full_messages }, status: :bad_request
    end
  end

  private

  def image_params
    params.permit(:blob)    
  end
end
