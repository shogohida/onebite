class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def scrape_duolingo
    # 1 -  DONE BUT TO CHECK with Trouni if correct - define routes to that controller action
    # 2 - DONE BUT TO CHECK - need a button on view which will trigger that route
      # raise
        # Clicking the refresh button does lead here
        # params returns => <ActionController::Parameters {"controller"=>"users", "action"=>"scrape_duolingo", "id"=>"23"} permitted: false>
    # 3- run the scraping inside of that controller action
      # retrieve the user in the DB using the params
      # call the service action duolingo_scraper
    @user = User.find(params[:id])
      # raise
      # @users returns => #<User id: 23, email: "julien.ergan@gmail.com", created_at: "2020-06-02 05:49:02", updated_at: "2020-06-02 06:58:11", name: "julien", streak: 0, sash_id: 1, level: 0>
    authorize @user
      # raise
      # returns NoMethodError in UsersController#scrape_duolingo > undefined method `scrape_duolingo?' for #<UserPolicy:0x00007fd7714f8ee0>
      # Meaning need to create a scrape_duolingo? in user policy
      # ASK TROUNI - should the method scrape_duolingo? in user policy be more restrictive than true? only allow the current.user to update his own stats?
      # raise - OK leads here
    DuolingoScraper.new(@user).scrape
      # raise
      # DuolingoScraper.new(@user).scrape returns => [] but (..)
      # DuolingoScraper.new(@user) does return an instance of DuolingoScraper which is => #<DuolingoScraper:0x00007fd778282c90 @user=#<User id: 23, email: "julien.ergan@gmail.com", created_at: "2020-06-02 05:49:02", updated_at: "2020-06-02 06:58:11", name: "julien", streak: 0, sash_id: 1, level: 0>, @user_profile_url="https://www.duolingo.com/profile/julienergan">
    # first use redirect to view
    redirect_to user_path(@user)
    # lastly try to render to the view using AJAX (tricky part)
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
    #raise

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
