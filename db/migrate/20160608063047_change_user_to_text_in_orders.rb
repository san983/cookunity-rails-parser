class ChangeUserToTextInOrders < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :orders do |t|
        dir.up   { t.change :user, :text }
        dir.down { t.change :user, :string }
      end
    end
  end
end
