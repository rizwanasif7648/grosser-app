class AddCustomerIdToRole < ActiveRecord::Migration[5.2]
  def change
  	add_reference :roles, :customer, index: true, foreign_key: true
  end
end
