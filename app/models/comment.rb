class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
  
    validates :content, presence: true
  end
  