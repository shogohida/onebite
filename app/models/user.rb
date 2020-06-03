class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :platforms, -> { distinct }, through: :courses
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # SETUP for gem acts_as_favoritor https://github.com/jonhue/acts_as_favoritor#setup
  # -  Add acts_as_favoritable to the models you want to be able to get favorited:
  acts_as_favoritable
  # - Specify which models can favorite other models by adding acts_as_favoritor:
  acts_as_favoritor
  has_merit

  def leaderboard_friends_for(course)
    # should return an array of enrollments
    # users_ids is an array of users ids including current_user id and followed users id
    users_ids = favorited_users.pluck(:id) + [id]
    Enrollment.where(user: users_ids, course: course).order(completion_status: :desc)
  end

  def enrollments_for(platform)
    enrollments.joins(:course).where(courses: { platform: platform })
  end
end
