class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    get_enrollment_stats
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

  private

  # this method loads stats for all the enrollments inside of @stats
  def get_enrollment_stats
    # get all the enrollments with current_user.enrollments
    current_user_enrollments = current_user.enrollments  # returns an array of enrollment instances
    # iterate over that array of enrollments
    user_enrollments.map do |enrollment|
      # 1 - check which platform each enrollment is for
      # 2 - use relevant scraper to get that structured data for that enrollment
      #  - need to specify the platform name to able to render the correct card in the view with the conditional statement (e.g. stat.platform)
      case current_user.enrollment.course.platform.name
      # julien = User.find(7)
      # julien.enrollments.first.course.platform.name returns "Codecademy"
      when 'duolingo'
        # julien.enrollments.first.completion_status returns 30
        # duolingo_scraped_data is an array of hashes like  [{:language=>"Spanish", :xp_points=>"7037"}, {:language=>"Korean", :xp_points=>"4770"}, ...]
        duolingo_scraped_data = DuolingoScraper.new(current_user.enrollment.platform_username).scrape
      end
      @stats << duolingo_scraped_data
    end
    # 3 - push that data into @stats
    return @stats
  end
end
