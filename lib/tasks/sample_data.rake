namespace :db do
  desc "Populate database with sample data"
  task populate: :environment do
    User.create!(name: "Joseph",
                 username: "Jose",
                 email: "jojoartz@yahoo.com",
                 gender: "male",
                 password: "123456",
                 password_confirmation: "123456")
    40.times do |n|
      name  = Faker::Name.name
      username = "user-#{n+1}"
      email = "user-#{n+1}@yahoo.com"
      gender = "male"
      password  = "password"
      User.create!(name: name,
                   username: username,
                   email: email,
                   gender: gender,
                   password: password,
                   password_confirmation: password)
    end
  end
end