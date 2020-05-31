class EnrollmentsController < ApplicationController
  def index
    @enrollments = policy_scope(Enrollment)
    # policy scope with Pundit installed
  end

  def show
    @enrollment = Enrollment.find(params[:id])
    authorize @enrollment
  end

  def new
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new
    authorize @enrollment
  end

  def create
    # creation of enrollment
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.course = @course
    @enrollment.completion_status = 0
    @enrollment.user = current_user
    # creation of time
    @time = @enrollment.time_of_day.to_s.split
    @time_split = @time[1].split(":")
    if (@enrollment.duration / 60) >= 1
      @add_hour = (@enrollment.duration / 60).to_i
      @add_minutes = @enrollment.duration - (@add_hour * 60)
      @time_split[0] = (@time_split[0].to_i + @add_hour).to_s
      @time_split[1] = (@time_split[1].to_i + @add_minutes).to_s
      @time << @time_split.join(":")
    else
      @add_minutes = @enrollment.duration
      @time_split[1] = (@time_split[1].to_i + @add_minutes).to_s
      @time << @time_split.join(":")
    end

    # creation of frequency
    @user_frequency = []
    case @enrollment.frequency
    when "Daily" then @user_frequency = ["DAILY", ""]
    when "Every Monday" then @user_frequency = ["WEEKLY", ";BYDAY=MO"]
    when "Every Tuesday" then @user_frequency = ["WEEKLY", ";BYDAY=TU"]
    when "Every Wednesday" then @user_frequency = ["WEEKLY", ";BYDAY=WE"]
    when "Every Thursday" then @user_frequency = ["WEEKLY", ";BYDAY=TH"]
    when "Every Friday" then @user_frequency = ["WEEKLY", ";BYDAY=FR"]
    when "Every Saturday" then @user_frequency = ["WEEKLY", ";BYDAY=SA"]
    when "Every Sunday" then @user_frequency = ["WEEKLY", ";BYDAY=SU"]
    end

    authorize @enrollment
    # raise

    if @enrollment.save
      AddToGoogleCalendar.add_events(@enrollment.course.title, @enrollment.course.description, @time, @user_frequency, @enrollment.course.chapters.count)
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:course_id, :user_id, :start_date, :completed_at, :duration, :time_of_day, :completion_status, :frequency)
  end
end
