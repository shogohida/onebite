FactoryBot.define do
  factory :user, class: User do
    name { 'User' }
    email { 'user@gmail.com' }
    password { '123456' }
  end
end
