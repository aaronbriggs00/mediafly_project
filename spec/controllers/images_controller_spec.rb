require 'rails_helper'
require './spec/support/controller_macros'

RSpec.configure do |c|
  c.include ControllerMacros
end

RSpec.describe ImagesController, type: :controller do
  before(:all) do
    @images = []
    5.times do
      @images.push(create(:image))
    end
    @working_file = Rack::Test::UploadedFile.new('spec/fixtures/files/test.jpeg', 'image/jpeg')
    @bad_file = Rack::Test::UploadedFile.new('spec/fixtures/files/test_gif.gif', 'image/gif')
  end 

  describe "GET images#index" do
    context "specs without authorization" do
      it "requires authentication" do
        get :index, params: { format: :json }
        expect(response.status).to eq(401)
      end
    end

    context "specs with authorization" do
      before(:each) do
        login_user
      end

      it "renders a response" do
        get :index, params: { format: :json }
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET images#show" do
    context "specs without authorization" do
      it "requires authentication" do
        get :show, params: { format: :json, id: @images[0].id }
        expect(response.status).to eq(401)
      end
    end

    context "specs with authorization" do
      before(:each) do
        login_user
      end

      it "renders a response" do
        get :index, params: { format: :json, id: @images[0].id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST images#screate" do
    context "specs without authorization" do
      it "requires authentication" do
        post :create, params: { format: :json }
        expect(response.status).to eq(401)
      end
    end

    context "specs with authorization" do
      before(:each) do
        login_user
      end

      it "validates file type" do
        post :create, params: { format: :json, blob: @bad_file }
        expect(response.status).to eq(400)
      end

      it "creates an image" do
        before_count = Image.count
        post :create, params: { format: :json, blob: @working_file }
        expect(response.status).to eq(201)
        expect(Image.count).not_to eq(before_count)
      end
    end
  end

  describe "GET images#mutate" do
    before(:each) do
      @image = Image.create(user_id: 1, status: 'complete')
    end

    context "specs without authorization" do
      it "requires authentication" do
        put :mutate, params: { format: :json, id: @image.id, options: {transformation: "rotate", angle: "180"} }
        expect(response.status).to eq(401)
      end
    end

    context "specs with authorization" do
      it "allows ApiKey access to access a mutated image" do
        include_api_key

        expect_any_instance_of(ImageMutatorService).to receive(:call)
        put :mutate, params: { format: :json, id: @image.id, options: {transformation: "rotate", angle: "180"} }
      end
    end
  end
end