class CodecademySearch

  def initialize(query)
    @query = query
  end

  def scrape
    # search submitted in a controller
    # codecademy_search = CodecademySearch.new(input keyword)
    # memo - only need @instance when need to pass it to the view
    # run it with codecademy_search.scrape
    puts @query
  end



end

