FactoryBot.define do
  factory :teacher, parent: :user, class: 'Teacher' do
    role  { 'Teacher' }
  end
end