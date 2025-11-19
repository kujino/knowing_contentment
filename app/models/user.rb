class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts

         validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
         validates :password, presence: true, on: :create
end
