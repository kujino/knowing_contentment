# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Theme.create!(
  title: "無常",
  description: <<~EOS
    無常とは、すべてのものごとは常に変化し続けており、変わらないものなど無いという教えです。
    仏教では、「この状態がずっと続いてほしい」という強い気持ちは、変化とのギャップによる苦しみに繋がるといわれています。

    今日という日の中で、あなたなりに感じた変化（無常）をみつけてみましょう。
    EOS
)