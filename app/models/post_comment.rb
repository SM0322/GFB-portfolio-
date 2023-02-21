class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  validates :message, presence: true
end
