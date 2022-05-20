class ChangeDefaultValueOfUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :is_web_user, :boolean, :default => true
  end
end
