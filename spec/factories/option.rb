FactoryBot.define do
  factory :option do
    question

    content   { Faker::Hipster.sentence }
    correct   { false }
  end
end