FactoryGirl.define do
  factory :user do
    name                  "Joseph"
    username              "Jose"
    email                 "jojoartz@yahoo.com"
    gender                "male"
    password              "password"
    password_confirmation "password"
  end
end