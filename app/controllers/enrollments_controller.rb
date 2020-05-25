class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
    # policy scope with Pundit installed
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
  end

  private

  def enrollment_params
    params.require(:enrollment).permit()
  end
end
