# frozen_string_literal: true

# app/auth/authenticate_user.rb
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  # this is where parameters are taken when the command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  # this is where the result gets returned
  def call
    @user = user
    token = JsonWebToken.encode(user_id: @user.id) if @user
    [token, @user]
  end

  private

  def user
    users = User.where(email: email.downcase)
    user = users.count.positive? ? users.first : nil
    return user if user.present? && user.valid_password?(password)

    errors.add :user_authentication, 'Invalid Email or Password.'
    nil
  end
end
