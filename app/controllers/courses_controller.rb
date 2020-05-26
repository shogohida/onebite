class CoursesController < ApplicationController
  def index
    # @enrollment = Enrollment.new
    if params[:query].present?
      @courses = policy_scope(Course).search_by_title(params[:query])
    else
      @courses = policy_scope(Course)
    end
  end

  def show
    @course = Course.find(params[:id])
  end
end
