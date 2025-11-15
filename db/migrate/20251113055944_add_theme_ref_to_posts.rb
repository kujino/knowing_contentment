class AddThemeRefToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :theme, null: false, foreign_key: true
  end
end
