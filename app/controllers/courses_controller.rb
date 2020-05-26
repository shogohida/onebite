class CoursesController < ApplicationController
  def index
    # @enrollment = Enrollment.new
    if params[:query].present?
      @courses = Course.search_by_title(params[:query])
    else
      @courses = Course.all
    end
  end

  def show
    @course = Course.find(params[:id])
  end
end
