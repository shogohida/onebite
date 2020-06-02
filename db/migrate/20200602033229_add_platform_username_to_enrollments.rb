class AddPlatformUsernameToEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :platform_username, :string
  end
end
