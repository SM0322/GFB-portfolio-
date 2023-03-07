class GroupChat < ApplicationRecord
  belongs_to :customer
  belongs_to :group
  
  validates :message, length: { in: 1..150 }
end
