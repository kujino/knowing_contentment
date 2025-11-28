class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts
         has_many :reactions, dependent: :destroy
         has_many :reaction_posts, through: :reactions, source: :post

         validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
         validates :password, presence: true, on: :create

         def reaction(post)
          reaction_posts << post
         end

         def unreaction(post)
          reaction_posts.destroy(post)
         end

         def reaction?(post)
          reaction_posts.include?(post)
         end
end
