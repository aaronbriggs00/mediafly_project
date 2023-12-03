require 'rails_helper'

RSpec.describe ImageMutatorService, type: :model do
  before(:all) do
    @image = create(:image)
    @working_file = Rack::Test::UploadedFile.new('spec/fixtures/files/test.jpeg', 'image/jpeg')
  end

  describe "#call should invoke the correct methods" do
    it "should return nil when no blob is present" do
      options = {
        "transformation" => "rotate",
        "angle" => "90"
      }
      mutator = ImageMutatorService.new(@image, options)
      expect(mutator).to receive(:call).and_return(nil)
      mutator.call()
    end

    context "with a functioning blob attached" do
      before(:all) do
        @image.blob.attach(@working_file)
      end

      it "should return nil when no mutation method is provided" do
        options = {}
        mutator = ImageMutatorService.new(@image, options)
        expect(mutator).to receive(:call).and_return(nil)
        mutator.call()
      end

      it "should call upon the correct mutation method" do
        options = {
          transformation: "rotate",
          angle: "90"
        }
        mutator = ImageMutatorService.new(@image, options)
        expect(mutator).to receive(:rotate)
        mutator.call()
      end
    end
  end
end