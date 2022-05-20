class AddCustomerIdInUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :customer, index: true, foreign_key: true
    rename_column :users, :profile_picture_url, :profile_picture
  end
end
