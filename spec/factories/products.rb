FactoryBot.define do
  factory :Product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end
end
