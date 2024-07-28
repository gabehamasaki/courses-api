# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


["Admin", "Member", "Teacher"].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end


begin
  value = ""; 25.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
  User.create!(name: "Gabriel Hamasaki",email: "gabriel.hamasaki@courses.com", password: value, role_id: 1)
  Logger.new(STDOUT).info("User created with email: gabriel.hamasaki@courses.com and password: #{value}")
rescue ActiveRecord::RecordInvalid
end

if Rails.env.development? || Rails.env.test?
  10.times do
    begin
      value = ""; 25.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
      User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: value, role_id: 2)
    rescue ActiveRecord::RecordInvalid
    end
  end
end

if Rails.env.development? || Rails.env.test?
  10.times do
    begin
      value = ""; 25.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
      User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: value, role_id: 3)
    rescue ActiveRecord::RecordInvalid
    end
  end
end
