# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
# require 'nokogiri'


puts 'Cleaning up the users...'
User.destroy_all

@user_julien = User.create!(
  name: 'julien',
  email: "julien.ergan@gmail.com",
  password: 'secret'
)
puts 'Finished creating user julien'

puts 'Cleaning up the chapers...'
Chapter.destroy_all
puts "Finished cleaning up the chapters"

puts 'Cleaning up the enrollments...'
Enrollment.destroy_all

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

chapter_one = Chapter.create!(
    name: "1 - Introduction to Ruby",
    course_id: @ruby.id
)
chapter_two = Chapter.create!(
    name: "2 - Control Flow in Ruby",
    course_id: @ruby.id
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

puts 'Creating the enrollments..'

# How to create a date - https://stackoverflow.com/questions/12544552/how-can-i-create-a-new-date-instance-in-ruby

@enrollment_ruby = Enrollment.create!(
  start_date: Date.new(2020, 6, 8),
  completed_at: nil,
  duration: 14,
  time_of_day: Time.new(2020, 6, 8, 21, 30),
  completion_status: 30,
  course_id: @ruby.id,
  user_id: @user_julien.id
)


puts "Finished creating #{Enrollment.count} enrollments!"


# scraping
# url = "https://www.codecademy.com/catalog/subject/all"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# html_doc.search('.wrapper__3fzpm0z50tenx2fYXBGSMJ').each do |section|
 # section.search('.header__dZgqyr9p7zUaFIBL72Yhb').each do |element|
  #  Course.create!(
   #   title: element.text.strip,
    #  url: "https://www.codecademy.com/learn/#{element.text.strip}",
     # platform_id: @codecademy.id
   # )
   # puts element.text.strip
    # puts element.attribute('href').value
 # end
# end


puts "Finished creating #{Course.count} courses!"
