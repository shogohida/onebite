class CodecademyScraper

  def initialize(course_id)
    @course_id = course_id
  end

  def fetch_courses_urls
    full_catalog_url = "https://www.codecademy.com/catalog/subject/all"
    doc = Nokogiri::HTML(open(full_catalog_url).read)
    courses = doc.search("#course a")
    courses.map do |course|
      uri = URI.parse(course.attributes["href"].value)
      uri.scheme = "http"
      uri.host = "www.codecademy.com"
      uri.query = nil
      uri.to_s
    end
  end

  def perform_scraping

  end


end
