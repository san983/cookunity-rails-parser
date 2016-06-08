class AddMoreAmountsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :product_total, :decimal
    add_column :orders, :sales_tax, :decimal
    add_column :orders, :delivery_fee, :decimal
  end
end
