class ChangeTimeOfDayToBeTimeInEnrollments < ActiveRecord::Migration[6.0]
  def change
    # change_column :table_name, :column_name, :new_type
    change_column :enrollments, :time_of_day, :time
  end
end
