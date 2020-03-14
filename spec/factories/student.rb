FactoryBot.define do
  factory :student, parent: :user, class: 'Student' do
    role  { 'Student' }
  end
end