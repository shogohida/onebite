FactoryBot.define do
  factory :chapter, class: Chapter do
    association :course
    name { 'Example' }
  end
end
