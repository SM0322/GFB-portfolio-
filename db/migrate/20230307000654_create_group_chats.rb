class CreateGroupChats < ActiveRecord::Migration[6.1]
  def change
    create_table :group_chats do |t|
      t.integer :customer_id
      t.integer :group_id
      t.string :message
      t.timestamps
    end
  end
end
