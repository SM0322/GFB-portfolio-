class AddRateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :rate, :float
  end
end
