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
    # raise
      # does return the array => [#<Nokogiri::XML::Element:0x3febb8958588 name="div" attributes=[#<Nokogiri::XML::Attr:0x3febb8958330 name="class" value="_3e2K7">] children=[#<Nokogiri::XML::Element:0x3febb8954514 name="div" attributes=[#<Nokogiri::XML::Attr:0x3febb8954460 name="class" value="_3NIZd">] children=[#<Nokogiri::XML::Text:0x3febb895d18c "Japanese">]>, #<Nokogiri::XML::Element:0x3febb895c91c name="div" children=[#<Nokogiri::XML::Text:0x3febb8ce5ee4 "Total XP: 168 XP">]>]>]
    stats = scraped_string.map do |element|
      regex = /Total XP: (\d+) XP/
      {
        language: element.children[0].text,
        xp_points: element.children[1].text.match(regex)[1]
      }
    end
    # raise
    stats.each do |stat|
      enrollment = @user.enrollments.joins(:platform, :course).find_by("courses.title = :title AND platforms.name = :platform", title: stat[:language], platform: "Duolingo")
      enrollment.completion_status = stat[:xp_points]
      enrollment.save
    end
    # raise
    p stats
    return stats
  end
end


