class AddMealsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :meals, :text
  end
end
