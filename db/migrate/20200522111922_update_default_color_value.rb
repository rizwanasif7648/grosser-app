class UpdateDefaultColorValue < ActiveRecord::Migration[5.2]
  def change
    Box.where(color: 'bg-blue').update_all(color: 'health-blue')
    Customer.where(color: 'bg-blue').update_all(color: 'health-blue')
    User.where(color: 'bg-blue').update_all(color: 'health-blue')
  end
end
