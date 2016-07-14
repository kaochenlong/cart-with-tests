FactoryGirl.define do
  factory :product do
    title { Faker::Name.name }
    price { Faker::Number.between(1500, 4000) }
    description { Faker::Lorem.paragraph }
  end
end

