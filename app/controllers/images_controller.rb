class ImagesController < ApplicationController
  before_action :authenticate_user

  def index
    render json: "image#index"
  end

  def show
    render json: "image#show"
  end

  def create
    render json: "image#create"
  end
end
