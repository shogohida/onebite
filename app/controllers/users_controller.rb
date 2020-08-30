class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def scrape_duolingo
    @platform = Platform.find_by(name: "Duolingo")
    @user = User.find(params[:id])
    authorize @user
    # scraping all leaderboard friends
    # users = @user.enrollments_for(@platform).map do |enrollment|
    #   @user.leaderboard_friends_for(enrollment.course)
    # end
    # users.flatten.map(&:user).uniq.each do |user|
    #   puts "scraping data for #{user.name}"
    #   p stats = DuolingoScraper.new(user).scrape
    # end
    previous_xp = @user.enrollments_for(@platform).sum(:completion_status)
    # TODO: Uncomment below when working on Heroku
    p DuolingoScraper.new(@user).scrape
    @user.reload
    new_xp = @user.enrollments_for(@platform).sum(:completion_status)
    # add one streak
    if previous_xp != new_xp
      @user.streak += 1
      @user.save
    end
    # TODO: Delete these 3 lines when working on Heroku
    # Shogo added these 3 lines from line 36-38 of duolingo_scraper.rb
    # enrollment = @user.enrollments.joins(:platform, :course).find_by("courses.title = :title AND platforms.name = :platform", title: "Japanese", platform: "Duolingo")
    # enrollment.completion_status += 5
    # enrollment.save

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
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
    redirect_to request.referrer
  end

  # method for current_user to unfollow another user
  def unfollow
    @user = User.find(params[:id])
    authorize @user
    current_user.unfavorite(@user)

    redirect_to request.referrer
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

  # WARNING - DO NOT USE this commented out code please - I wish to keep it purely for future reference (Julien)
  # def get_enrollment_stats
  #   # this method loads stats for all the enrollments inside of @stats
  #   @stats = {}
  #   # get all the enrollments with current_user.enrollments
  #   current_user_enrollments = current_user.enrollments  # returns an array of enrollment instances
  #   # iterate over that array of enrollments
  #   current_user_enrollments.map do |enrollment|
  #     # 1 - check which platform each enrollment is for
  #     # 2 - use relevant scraper to get that structured data for that enrollment
  #     #  - need to specify the platform name to able to render the correct card in the view with the conditional statement (e.g. stat.platform)
  #     case enrollment.course.platform.name
  #     # julien = User.find(7)
  #     # julien.enrollments.first.course.platform.name returns "Codecademy"
  #     when 'Duolingo'
  #       # julien.enrollments.first.completion_status returns 30
  #       # duolingo_scraped_data is an array of hashes like  [{:language=>"Spanish", :xp_points=>"7037"}, {:language=>"Korean", :xp_points=>"4770"}, ...]
  #       @stats[:duolingo] = DuolingoScraper.new(@user).scrape
  #       # { duolingo:[{:language=>"Spanish", :xp_points=>"7037"}, {:language=>"Korean", :xp_points=>"4770"}, ...] }
  #     end
  #   end
  #   # 3 - push that data into @stats
  #   return @stats
  # end
end
