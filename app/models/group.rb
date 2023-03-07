class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers
  
  has_one_attached :image
  
  validates :name, presence: true
  validates :introduction, presence: true
end
