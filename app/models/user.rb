class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :enrollments
  has_many :courses, through: :enrollments
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # SETUP for gem acts_as_favoritor https://github.com/jonhue/acts_as_favoritor#setup
  # -  Add acts_as_favoritable to the models you want to be able to get favorited:
  acts_as_favoritable
  # - Specify which models can favorite other models by adding acts_as_favoritor:
  acts_as_favoritor
  has_merit
end
