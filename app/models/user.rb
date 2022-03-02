class User < ApplicationRecord
  acts_as_voter
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 40 }
  validates :name, presence: true, length: { maximum: 100 }
  
end
