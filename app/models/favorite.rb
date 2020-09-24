class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes

  belongs_to :favoritable, polymorphic: true
  delegate :name, :courses, :to => :favoritable, :prefix => true
  belongs_to :favoritor, polymorphic: true

  # def block!
  #   update!(blocked: true)
  # end
end
