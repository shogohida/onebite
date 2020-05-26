# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
# require 'nokogiri'

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

# scraping
url = "https://www.codecademy.com/catalog/subject/all"
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.wrapper__3fzpm0z50tenx2fYXBGSMJ').each do |section|
  section.search('.header__dZgqyr9p7zUaFIBL72Yhb').each do |element|
    Course.create!(
      title: element.text.strip,
      url: "https://www.codecademy.com/learn/#{element.text.strip}",
      platform_id: @codecademy.id
    )
    puts element.text.strip
    # puts element.attribute('href').value
  end
end

puts "Finished creating #{Course.count} courses!"
