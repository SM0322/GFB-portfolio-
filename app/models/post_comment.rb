class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :message, length: { in: 2..150 }
end
