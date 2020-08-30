class ChaptersController < ApplicationController
  def update
    @chapter = Chapter.find(params[:id])
    # @user = User.find(params[:user_id])?
    # @enrollment = Enrollment.find(params[:enrollment_id])?
    # @course = Course.find(params[:course_id])?
    @chapter.update(chapter_params)
    #@chapter.save
    authorize @chapter
    # if @chapter.save
    #   redirect_to root_path
    #   current_user.streak += 1 (@user?)
    #   @chapter.course.enrollments....
    #   @enrollment.completion_status = (@enrollment.completion_status * @course.chapters.count + 1) / @course.chapters.count
    # else
    #   redirect_to courses_path
    # end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:done, :id, :name, :course_id)
  end
end
