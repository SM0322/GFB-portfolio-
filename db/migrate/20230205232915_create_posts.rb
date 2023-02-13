class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.string :title
      t.string :introduction
      t.float :rate
      t.timestamps
    end
  end
end
