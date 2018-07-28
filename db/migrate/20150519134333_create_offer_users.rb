class CreateOfferUsers < ActiveRecord::Migration
  def change
    create_table :offer_users do |t|
      t.integer :user_id
      t.integer :offer_id
      t.boolean :status
      t.float :price
      t.float :quantity

      t.timestamps null: false
    end
  end
end
