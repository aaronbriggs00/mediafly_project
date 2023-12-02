require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "Validations" do
    before(:all) do
      password = Faker::Internet.password
      @user = User.create(username: Faker::Name.first_name, password: password, password_confirmation: password)
    end

    subject { described_class.new(user_id: @user.id) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is not valid without a user_id" do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end

  describe "#fetch_filename" do
    it "returns the name of the attached file" do
      working_file = Rack::Test::UploadedFile.new('spec/fixtures/files/test.jpeg', 'image/jpeg')
      image = create(:image)
      image.blob.attach(working_file)
      expect(image.fetch_filename).to eq("test.jpeg")
    end
  end
end
