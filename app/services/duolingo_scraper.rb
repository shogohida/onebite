require 'open-uri'
class DuolingoScraper

  def initialize(user)
    @user = user
    @username =  user.enrollments.joins(:platform).find_by("platforms.name = ?", "Duolingo").platform_username
  end

  def scrape
    timestamp = DateTime.now.strftime('%Q')
    url = "https://en.duolingo.com/2017-06-30/users?username=#{@username}&_=#{timestamp}"
    data = JSON.parse(open(url).read)
    stats = data['users'][0]['courses']
    stats.each do |stat|
      enrollment = @user.enrollments.joins(:platform, :course).find_by("courses.title = :title AND platforms.name = :platform", title: stat["title"], platform: "Duolingo")
      enrollment.completion_status = stat["xp"]
      enrollment.save
    end
    p stats
    return stats
  end
end


