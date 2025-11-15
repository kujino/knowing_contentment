class AddTitleIdToThemes < ActiveRecord::Migration[7.2]
  def change
    add_column :themes, :title_id, :integer, null: true
  end
end
