class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :completed_at
      t.integer :duration
      t.datetime :time_of_day
      t.integer :completion_status

      t.timestamps
    end
  end
end
