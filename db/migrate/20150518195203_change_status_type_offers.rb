class ChangeStatusTypeOffers < ActiveRecord::Migration
  def change
  	remove_column :offers, :status,  :boolean
  end
end
