class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :unit

      t.timestamps null: false
    end
  end
end
