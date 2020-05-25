class Platform < ApplicationRecord
  has_many :courses
  validates :name, presence: true
  validates :url, presence: true
  # need to think about how to validate url
end
