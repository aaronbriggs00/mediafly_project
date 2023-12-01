require 'rails_helper'

RSpec.describe ImageUploaderService, type: :model do
  before(:all) do
    @working_file = Rack::Test::UploadedFile.new('spec/fixtures/files/test.jpeg', 'image/jpeg')
    @image = create(:image)
  end

  describe "#call" do
    it "should update the status of the image" do
      ImageUploaderService.call(@working_file, @image, {})
      expect(@image.status).to_not eq('processing')
    end
  end
end