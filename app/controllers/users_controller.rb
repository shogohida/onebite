class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def index
    if params[:query].present?
      @users = policy_scope(User).where(name: params[:query])
    else
      @users = policy_scope(User)
    end
    # authorisation error - https://github.com/varvet/pundit#ensuring-policies-and-scopes-are-used
    # see example from courses_controller.rb
  end

  # method for current_user to follow another user
  def follow
    @user = User.find(params[:id])
    authorize @user
    current_user.favorite(@user)
    #raise
    if @user.save
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  # method for current_user to unfollow another user
  def unfollow
    @user = User.find(params[:id])
    authorize @user
    current_user.unfavorite(@user)
    #raise
    if @user.save
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

   # method for current_user to see the list of other users he/she is following
  def following
    current_user.all_favorites
  end

  # method for current_user to see the list of other users he/she is being followed by
  def followers
    current_user.all_favorited
  end
end
