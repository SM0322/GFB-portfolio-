class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers
  has_many :group_chats, dependent: :destroy
  
  has_one_attached :group_image
  
  validates :name, presence: true
  validates :introduction, presence: true
end
