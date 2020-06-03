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

  def initialize(user)
    @user = user
    username =  user.enrollments.joins(:platform).find_by("platforms.name = ?", "Duolingo").platform_username
    @user_profile_url = "https://www.duolingo.com/profile/#{username}"
  end

  def scrape
    browser = Watir::Browser.new(:chrome, headless: true)
    browser.goto(@user_profile_url)
    doc = Nokogiri::HTML.parse(browser.html)
    browser.close
    scraped_string = doc.search("._3e2K7")
    stats = scraped_string.map do |element|
      regex = /Total XP: (\d+) XP/
      {
        language: element.children[0].text,
        xp_points: element.children[1].text.match(regex)[1]
      }
    end
    stats.each do |stat|
      enrollment = @user.enrollments.joins(:platform, :course).find_by("courses.title = :title AND platforms.name = :platform", title: stat[:language], platform: "Duolingo")
      enrollment.completion_status = stat[:xp_points]
      enrollment.save
    end
    return stats
  end
end


