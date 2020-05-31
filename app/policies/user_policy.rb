class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
    # record.id == user.id
  end

  def follow?
    true
  end

  def unfollow?
    true
  end
end
