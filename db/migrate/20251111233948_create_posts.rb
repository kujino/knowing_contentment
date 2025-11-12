class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.boolean :is_anonymous, default: true, null: false
      t.timestamps
    end
  end
end
