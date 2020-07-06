class CoursesController < ApplicationController
  def index
    if params[:query].present?
      @courses = policy_scope(Course).search_by_title(params[:query])
    else
      @courses = policy_scope(Course)
    end
  end


  def show
    # update the completion and syllabus structure
    # scraper = CodecademyScraper.new(@course.platform_id)
    # scaper.perform_scraping
    @course = Course.find(params[:id])
    authorize @course
  end
end
