class AddAccountToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :account, :string
  end
end
