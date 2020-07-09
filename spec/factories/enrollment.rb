FactoryBot.define do
  factory :enrollment, class: Enrollment do
    association :user
    association :course
    # association :platform?
  end
end
