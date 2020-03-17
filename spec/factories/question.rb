FactoryBot.define do
  factory :question do
    test

    label   { Faker::Book.title }
    description   { Faker::Lorem.question }
  end
end