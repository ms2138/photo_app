class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many_attached :images
  has_many :comments, -> { order('created_at desc') }, dependent: :destroy

  validates :content, presence: true
end
