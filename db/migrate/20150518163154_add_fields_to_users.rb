class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rol, :string
    add_column :users, :name, :string
    add_column :users, :carrier, :string
    add_column :users, :landline, :string
    add_column :users, :cell_phone, :string
    add_column :users, :container, :boolean
    add_column :users, :liquid_charge, :boolean
    add_column :users, :dry_charge, :boolean
  end
end
