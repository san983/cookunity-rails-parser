class AddTotalToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total, :decimal
  end
end
