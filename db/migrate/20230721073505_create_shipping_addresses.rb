class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.string     :post_code,       null: false
      t.integer    :prefecture_id,   null: false   
      t.integer    :city,            null: false  
      t.integer    :address,         null: false 
      t.integer    :building_name,   null: false 
      t.integer    :phone_number,    null: false 
      t.references :purchase_record, null: false, foreign_key: true
      t.timestamps
    end
  end
end
