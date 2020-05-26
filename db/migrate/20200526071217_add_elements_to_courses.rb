class AddElementsToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :description, :text
    add_column :courses, :rating, :float
    add_column :courses, :difficulty, :string
    add_column :courses, :expected_time_to_complete, :string
    add_column :courses, :cost, :string
  end
end
