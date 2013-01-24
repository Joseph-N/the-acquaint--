FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Person#{n}"} 
    sequence(:username) { |n| "username_#{n}"}
    sequence(:email) { |n| "person_#{n}@gmail.com"}
    gender                "male"
    password              "password"
    password_confirmation "password"
  end
end