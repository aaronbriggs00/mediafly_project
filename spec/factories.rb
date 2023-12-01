FactoryBot.define do

  factory :image do
    association :user
    status { "processing" }
  end
  
  factory :user do
    username { Faker::Alphanumeric.alpha(number: 10) }
    password { "password" }
    password_confirmation { "password" }
  end

end