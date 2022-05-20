# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  name                   :string
#  phone                  :string
#  profile_picture        :string
#  status                 :integer          default("active")
#  is_web_user            :boolean          default(TRUE)
#  is_superuser           :boolean          default(FALSE)
#  created_by_id          :integer
#  updated_by_id          :integer
#  role_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  customer_id            :bigint
#  color                  :string           default("health-blue")
#  player_id              :string
#
class User < ApplicationRecord
  include UserValidations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_picture, PictureUploader

  belongs_to :customer
  belongs_to :role
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true
  has_many :user_boxes, dependent: :destroy
  has_many :boxes, through: :user_boxes
  has_many :incidents
  has_many :user_settings
  has_many :notifications
  has_many :incident_requests

  accepts_nested_attributes_for :user_settings
  after_create :generate_user_settings
  after_commit :archive_user, if: :saved_change_to_status?, on: :update
  default_scope do
    where.not(status: 'archived')
  end

  scope :possible_users_list_for_box, ->(box) { where.not(id: box.users.pluck(:id)) }
  scope :mobile, -> { where(is_web_user: false) }
  scope :web, -> { where(is_web_user: true) }

  enum status: %w[inactive active archived]

  def archive_user
    return unless archived?

    new_email = "#{email}." + SecureRandom.uuid
    update(email: new_email)
  end

  def profile_picture_src
    profile_picture_url.present? ? profile_picture_url(:square) : 'no_image'
  end

  def customer_name
    customer.name
  end

  def role_title
    role&.title
  end

  def authorized_user?
    Permission.authorized?(role.id, 'Customers', 'is_readable')
  end

  def type
    is_web_user ? 'Web User' : 'Mobile User'
  end

  def validate_user
    message = 'has set to be Inactive.'
    return [false, 'This User is not a Web User.'] unless is_web_user?

    return [false, "Your Company #{message}"] unless Customer.find(customer_id).active?

    [false, "Your Account #{message}"] unless active?
  end

  def update_with_password(params)
    return unless valid_password? params[:current_password]

    reset_password(params[:password], params[:password_confirmation])
  end

  def generate_user_settings
    %w[email push].each do |type|
      %w[create_incident product_expiry resupply_point].each do |notification|
        user_settings.create(notification_type: type, notification: notification, flag: true)
      end
    end
  end

  def change_color_to_yellow
    update(color: 'health-yellow') if color != 'health-red'
  end

  def change_color_to_red
    update(color: 'health-red')
  end

  def receiving_notification?(type, trigger)
    setting = user_settings.find_by(notification_type: type, notification: trigger)
    setting.flag if setting.present?
  end
end
