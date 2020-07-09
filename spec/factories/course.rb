FactoryBot.define do
  factory :course, class: Course do
    association :platform
    title { 'Example' }
    url { 'example.com' }
  end
end
