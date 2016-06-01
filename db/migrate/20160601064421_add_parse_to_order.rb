class AddParseToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :parsed, :boolean, default: false
  end
end
