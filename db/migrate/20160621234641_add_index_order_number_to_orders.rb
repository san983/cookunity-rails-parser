class AddIndexOrderNumberToOrders < ActiveRecord::Migration[5.0]
  def change
    add_index :orders, :order_number
  end
end
