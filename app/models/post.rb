class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many_attached :images
  
  validates :title, presence: true
  validates :introduction, presence: true
  validates :images, presence: true
  validates :rate, presence: true
  validates :tag_ids, presence: true
  
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
  
  def get_image
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      images
  end
end
