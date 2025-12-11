class AddUuidToPosts < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    add_column :posts, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :posts, :uuid, unique: true
  end
end
