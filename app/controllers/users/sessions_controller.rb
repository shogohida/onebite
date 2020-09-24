class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    # redirect_back(fallback_location: root_path), notice: "Logged in as a test user"
  end
end
