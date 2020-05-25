class Course < ApplicationRecord
  belongs_to :platform
  has_many :enrollments
  has_many :chapters
  validates :title, presence: true
  validates :url, presence: true
end
