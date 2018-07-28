class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :product
      t.string :origins
      t.string :destination
      t.float :volumen
      t.float :price
      t.boolean :container
      t.boolean :general_load
      t.boolean :liquid_load
      t.boolean :load_compensation
      t.string :offert_type
      t.string :unit
      t.text :observation
      t.boolean :status
      t.date :service_start_date
      t.date :offer_finish_date
      t.date :offer_start_date
      t.date :service_finish_date

      t.timestamps null: false
    end
  end
end
