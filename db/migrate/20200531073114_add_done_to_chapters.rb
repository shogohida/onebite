class AddDoneToChapters < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :done, :boolean, default: false
  end
end
