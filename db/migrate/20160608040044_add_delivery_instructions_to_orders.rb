class AddDeliveryInstructionsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :delivery_instructions, :string
  end
end
