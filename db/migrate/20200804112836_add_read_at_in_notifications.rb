class AddReadAtInNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :read_at, :datetime, :default => nil
  end
end
