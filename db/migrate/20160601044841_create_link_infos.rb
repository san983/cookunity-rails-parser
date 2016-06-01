class CreateLinkInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :link_infos do |t|
      t.integer :order_id
      t.integer :vendor_location_id
      t.string :token
      t.boolean :auto_print, default: false

      t.timestamps
    end
  end
end
