class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags
  has_many_attached :images
  has_many :comments, -> { order('created_at desc') }, dependent: :destroy
  after_commit :create_hash_tags, on: :create

  validates :content, presence: true, length: { minimum: 1, maximum: 300 }
  validates :images, attached: true, content_type: ['image/png', 'image/jpeg']

  def create_hash_tags
    scan_for_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end
  
  def scan_for_hash_tags
    content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end
end
