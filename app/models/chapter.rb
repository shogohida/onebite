class Chapter < ApplicationRecord
  belongs_to :course
  has_many :chapters
  validates :name, presence: true
end
