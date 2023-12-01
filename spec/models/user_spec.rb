require 'rails_helper'

RSpec.describe User, :type => :model do
  password = Faker::Internet.password
  subject { described_class.new(password: password, password_confirmation: password, username: Faker::Name.first_name) }

  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a username" do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password_digest = nil
      expect(subject).to_not be_valid
      expect(User.new(username: Faker::Name.first_name)).to_not be_valid
    end
  end
end