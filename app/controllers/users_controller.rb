class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  # method for current_user to follow another user
  def follow
    @user = User.find(params[:id])
    authorize @user
    current_user.favorite(@user)
    redirect_to user_path(@user)
  end

  # method for current_user to unfollow another user
  def unfollow
    @user = User.find(params[:id])
    authorize @user
    current_user.unfavorite(@user)
    redirect_to user_path(@user)
  end

   # method for current_user to see the list of other users he/she is following
  def following
  end

  # method for current_user to see the list of other users he/she is being followed by
  def followers
  end
end
