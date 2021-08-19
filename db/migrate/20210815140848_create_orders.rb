class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :phone
      t.text :description
      t.integer :user_id
      t.integer :total_price

      t.timestamps
    end
  end
end
