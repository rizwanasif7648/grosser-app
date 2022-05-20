class AddUserSettingsForExistingUsers < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |user|
      user.generate_user_settings
    end
  end
end
