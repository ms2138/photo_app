class User < ApplicationRecord
  acts_as_voter
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
            foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
            foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 40 }
  validates :name, presence: true, length: { maximum: 100 }
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id" 
    Post.where("user_id IN (#{following_ids})
                OR user_id = :user_id", user_id: id)
  end

  def liked
    liked_posts_ids = "SELECT votable_id FROM votes
                       WHERE voter_id = :user_id"
    Post.where("id IN (#{liked_posts_ids})", user_id: id)
  end

  def follow(user)
    following << user
  end

  def unfollow(user)
    following.delete(user)
  end

  def following?(user)
    following.include?(user)
  end
end
