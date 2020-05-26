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
  description: "Learn the JavaScript fundamentals you'll need for front-end or back-end development.",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 25,
  platform_id: @codecademy.id
)
@ruby = Course.create!(
  title: 'Learn Ruby',
  url: 'https://www.codecademy.com/learn/learn-ruby',
  description: "Learn to program in Ruby, a ﬂexible and beginner-friendly language used to create sites like Codecademy.",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 8,
  platform_id: @codecademy.id
)

@learn_html = Course.create!(
  title: 'Learn HTML',
  url: 'https://www.codecademy.com/learn/learn-html',
  description: "Learn the basics of HMTL5 and start building & editing web pages",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 10,
  platform_id: @codecademy.id
)

@learn_python = Course.create!(
  title: 'Learn Python 2',
  url: 'https://www.codecademy.com/learn/learn-python',
  description: "Learn the basics of the world's fastest growing and most popular programming language used by software engineers, analysts, data scientists, and machine learning engineers alike.",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 25,
  platform_id: @codecademy.id
)

@learn_sql = Course.create!(
  title: 'Learn SQL',
  url: 'https://www.codecademy.com/learn/learn-sql',
  description: "Learn to communicate with databases using SQL, the standard data management language.",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 7,
  platform_id: @codecademy.id
)

@learn_c_plus_plus = Course.create!(
  title: 'Learn C++',
  url: 'https://www.codecademy.com/learn/learn-c-plus-plus',
  description: "Learn one of the most powerful programming languages in the world and become a rockstar developer.",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 20,
  platform_id: @codecademy.id
)

@learn_go = Course.create!(
  title: 'Learn Go',
  url: 'https://www.codecademy.com/learn/learn-go',
  description: "Learn how to use Go (Golang), an open-source programming language supported by Google!",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 9,
  platform_id: @codecademy.id
)

@learn_bootstrap = Course.create!(
  title: 'Learn Bootstrap',
  url: 'https://www.codecademy.com/learn/learn-bootstrap',
  description: "Give your website a clear layout and polished style—fast! Learn how to use one of the most popular front-end frameworks, Bootstrap 4!",
  rating: nil,
  difficulty: nil,
  expected_time_to_complete: 3,
  platform_id: @codecademy.id
)


puts "Finished creating #{Course.count} courses!"
