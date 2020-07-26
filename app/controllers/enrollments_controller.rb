class EnrollmentsController < ApplicationController
  skip_before_action :authenticate_user!,
  def index
    @enrollments = policy_scope(Enrollment)
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
    # @date = @enrollment.start_date.to_s.split("-")
    @start_time = @enrollment.time_of_day.to_s.split[1].split(":")
    # @time_split = @time.split(":")
    # raise
    @end_time = []
    if (@enrollment.duration / 60) >= 1
      @add_hour = (@enrollment.duration / 60).to_i
      @add_minutes = @enrollment.duration - (@add_hour * 60)
      @end_time[0] = (@start_time[0].to_i + @add_hour).to_s
      @end_time[1] = (@start_time[1].to_i + @add_minutes).to_s
      @end_time[2] = "00"
      @end_time << @end_time.join(":")
    else
      @add_minutes = @enrollment.duration
      @end_time[0] = @start_time[0]
      @end_time[1] = (@start_time[1].to_i + @add_minutes).to_s
      @end_time[2] = "00"
      @end_time << @end_time.join(":")
    end

    # creation of frequency
    @user_frequency = []
    @count = @enrollment.course.chapters.count
    case @enrollment.frequency
    when "Daily" then @user_frequency = ["DAILY", ""]
    when "Weekend"
      @user_frequency = ["WEEKLY", ";BYDAY=SA,SU"]
      @count = (@enrollment.course.chapters.count / 2)
    when "Every Monday" then @user_frequency = ["WEEKLY", ";BYDAY=MO"]
    when "Every Tuesday" then @user_frequency = ["WEEKLY", ";BYDAY=TU"]
    when "Every Wednesday" then @user_frequency = ["WEEKLY", ";BYDAY=WE"]
    when "Every Thursday" then @user_frequency = ["WEEKLY", ";BYDAY=TH"]
    when "Every Friday" then @user_frequency = ["WEEKLY", ";BYDAY=FR"]
    when "Every Saturday" then @user_frequency = ["WEEKLY", ";BYDAY=SA"]
    when "Every Sunday" then @user_frequency = ["WEEKLY", ";BYDAY=SU"]
    end

    authorize @enrollment
    #raise

    if @enrollment.save
      AddToGoogleCalendar.add_events(@enrollment.course.title, @enrollment.course.description, @enrollment.start_date, @start_time.join(":"), @end_time, @user_frequency, @count)
      #redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def update
    @enrollment = Enrollment.find(params[:id])
    @enrollment.update(enrollment_params)
    authorize @enrollment
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:course_id, :user_id, :start_date, :completed_at, :duration, :time_of_day, :completion_status, :frequency, :platform_username)
  end
end
