class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :customer_id
      t.integer :post_id
      t.string :message
      t.timestamps
    end
  end
end
