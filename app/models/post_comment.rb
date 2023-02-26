class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :message, length: { in: 1..150 },
                      uniqueness: true
end
