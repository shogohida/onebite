# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning up the courses...'
Course.destroy_all

# platform part unnecessary?
puts 'Cleaning up the platforms...'
Platform.destroy_all

puts 'Creating the platforms..'
@codecademy = Platform.create!(
  name: 'Codecademy',
  url: 'https://www.codecademy.com'
)
@wanikani = Platform.create!(
  name: 'Wanikani',
  url: 'https://www.wanikani.com'
)

puts "Finished creating #{Platform.count} platforms!"

puts 'Creating courses...'

@javascript = Course.create!(
  title: 'Learn JavaScript',
  url: 'https://www.codecademy.com/learn/introduction-to-javascript',
  platform_id: @codecademy.id
)
@ruby = Course.create!(
  title: 'Learn Ruby',
  url: 'https://www.codecademy.com/learn/learn-ruby',
  platform_id: @codecademy.id
)

puts "Finished creating #{Course.count} courses!"
