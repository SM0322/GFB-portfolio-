class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?   #unlessでタグが存在するか確認し、存在するならばcurrent_tagsという変数にタグ名を配列として習得する。
    old_tags = current_tags - sent_tags                           #(例)既にa,b,cのタグが存在し、新たにb,dのタグが登録されると、old_tags = a,cとなる
    new_tags = sent_tags - current_tags                           #(例)既にa,b,cのタグが存在し、新たにb,dのタグが登録されると、new_tags = dとなる
    
    old_tags.each do |old|                                        #このメソッドで古いタグを消去する。例でいうところのold_tags = a,cが消去される。
      self.tags.delete
      Tag.find_by(name: old)
    end 
    
    new_tags.each do |new|                                        #このメソッドで新しく登録されたnew_tags = dが保存される。
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end 
  end 
end