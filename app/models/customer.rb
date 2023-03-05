class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :group_customers, dependent: :destroy
  has_many :groups, through: :group_customers
  
  has_one_attached :profile_image
  
  validates :name, length: { in: 1..20 },
                   uniqueness: true
  validates :email, presence: true, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    else search == "partial_match"
      @customer = Customer.where("name LIKE?", "%#{word}%")
    end 
  end
  
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end 
  
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  
  def following?(customer)
    followings.include?(customer)
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@guest.mail') do |customer|
      customer.name = 'ゲストユーザー'
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
