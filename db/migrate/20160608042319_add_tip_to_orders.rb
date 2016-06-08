class AddTipToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :tip, :decimal
  end
end
