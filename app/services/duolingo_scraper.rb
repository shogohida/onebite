class DuolingoScraper

# duolingo_users = [
#   'rory678',
#   'trouni',
#   'Algarve11',
#   'r0ventura',
#   'Rundmaus',
#   'moonsunalphas099'
    # 'dberks'
# ]

  def initialize(username)
    @user_profile_url = "https://www.duolingo.com/profile/#{username}"
  end

  def scrape
    browser = Watir::Browser.new
    browser.goto(@user_profile_url)
    doc = Nokogiri::HTML.parse(browser.html)
    browser.close
    # TODO: structure the scraped data into a hash
    # [ { language: 'english', xp_points: '3000'}, { language: 'italian', xp_points: '2500'} ]

    scraped_string = doc.search("._3e2K7").text.strip
    elements_of_string = scraped_string.split
    i = 0
    # data_hash = {}
    array = []
       data_hash = {
         language: elements_of_string[i][0..-6],
         xp_points: elements_of_string[i + 2]
       }
       array << data_hash
       i += 3
       while i < elements_of_string.length - 1
         data_hash = {
           language: elements_of_string[i][2..-6],
           xp_points: elements_of_string[i + 2]
         }
         array << data_hash
         i += 3
       end
    return array
  end
end


