FactoryBot.define do
  factory :test do
    sequence(:name) { |i| "Test #{i}" }
    description     { Faker::Food.description }
  end
end