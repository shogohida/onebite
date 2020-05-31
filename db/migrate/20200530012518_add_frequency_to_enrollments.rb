class AddFrequencyToEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :frequency, :string
  end
end
