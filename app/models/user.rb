class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :enrollments
  has_many :courses, through: :enrollments
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # setup for gem acts_as_favoritor
  # see link here https://github.com/jonhue/acts_as_favoritor#setup
  acts_as_favoritable
  acts_as_favoritor
end
