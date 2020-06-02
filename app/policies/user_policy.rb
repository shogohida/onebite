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

  # def index?
  #   true
  # end

  def mystats?
    true
  end

  def follow?
    true
    # current_user can follow / anyone any user except himself / herself
    # in pundit current_user is called user, so how a user is called?
    # in this case user is current_user and record is user
    # user.id != record.id
  end

  def unfollow?
    true
    # user.id != record.id
  end
end
