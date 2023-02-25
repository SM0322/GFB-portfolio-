class Post < ApplicationRecord
  FILE_NUMBER_LIMIT = 3
  
  belongs_to :customer
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many_attached :images
  
  validates :title, presence: true
  validates :introduction, presence: true
  validates :rate, presence: true
  validates :tag_ids, presence: true
  validates :images, presence: true
  validate :validate_number_of_files

  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    else search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    end 
  end
  
  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "に添付できる画像は#{FILE_NUMBER_LIMIT}件までです。")
  end
end
