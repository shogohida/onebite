class DuolingoScraper

  def initialize(username)
    @user_profile_url = "https://www.duolingo.com/profile/#{username}"
  end

  def scrape
    browser = Watir::Browser.new
    browser.goto(@user_profile_url)
    doc = Nokogiri::HTML.parse(browser.html)
    browser.close
    return doc.search("._3e2K7").text.strip
  end
end
