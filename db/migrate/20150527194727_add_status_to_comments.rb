class AddStatusToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :subject, :string
    add_column :comments, :status, :integer
  end
end
