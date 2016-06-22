class AddFailedParsingToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :failed_parsing, :boolean, default: false
  end
end
