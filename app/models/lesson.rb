class Lesson < ApplicationRecord
  belongs_to :chapte
  def start_time
    self.chapter.course.enrollments.last.start_date.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
