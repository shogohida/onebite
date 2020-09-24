class Course < ApplicationRecord
  belongs_to :platform
  delegate :name, :to => :platform, :prefix => true
  has_many :enrollments
  has_many :chapters
  has_many :lessons, through: :chapters
  validates :title, presence: true
  validates :url, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }
end
