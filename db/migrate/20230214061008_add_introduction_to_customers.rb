class AddIntroductionToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :introduction, :string
  end
end
