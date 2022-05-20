# frozen_string_literal: true

# == Schema Information
#
# Table name: boxes
#
#  id            :bigint           not null, primary key
#  code          :string
#  customer_id   :bigint
#  location      :string           not null
#  box_type      :string
#  status        :integer          default("active")
#  min_products  :integer
#  max_products  :integer
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#  color         :string           default("health-blue")
#
require 'rqrcode'

class Box < ApplicationRecord
  WHITELIST_ATTRIBUTES = [
    :code, :customer_id, :location, :box_type, :status, :min_products, :max_products,
    user_boxes_attributes: UserBox::WHITELIST_ATTRIBUTES,
    product_boxes_attributes: ProductBox::WHITELIST_ATTRIBUTES
  ].freeze

  before_create :generate_box_code
  after_create :generate_box_code, :generate_qr_code
  mount_uploader :qrcode_url, PictureUploader

  belongs_to :customer
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'

  has_many :user_boxes, dependent: :destroy
  has_many :replenishments, dependent: :destroy
  has_many :users, through: :user_boxes
  has_many :product_boxes, dependent: :destroy
  has_many :products, through: :product_boxes
  has_many :incidents, dependent: :destroy

  default_scope do
    where.not(status: 'archived')
  end

  accepts_nested_attributes_for :user_boxes, allow_destroy: true,
                                             reject_if: :all_blank
  accepts_nested_attributes_for :product_boxes, allow_destroy: true,
                                                reject_if: :all_blank

  validates :location, presence: true
  validates :min_products, numericality: { less_than_or_equal_to: :max_products,
                                           message: 'must be less than Max products' }
  enum status: %w[inactive active archived]

  def generate_box_code
    loop do
      self.code = location[0..2] + rand.to_s[2..5]
      break unless Box.find_by_code(code)
    end
  end

  def generate_qr_code
    box = self
    qrcode = RQRCode::QRCode.new(code)
    begin
      unless Dir.exist?(Rails.root.join('tmp/uploader/'))
        Dir.mkdir(Rails.root.join('tmp/uploader/'))
      end
      qrcode_path = "tmp/uploader/qrcode_#{code}.png"
      png = qrcode.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 180,
        border_modules: 4,
        module_px_size: 6,
        file: nil
      )

      File.open("tmp/uploader/qrcode_#{code}.png", 'wb') { |f| f.write(png.to_s) }
      src_file = File.new(File.join(Rails.root, qrcode_path))
      box.qrcode_url = src_file
      box.save!
      FileUtils.rm_rf Dir.glob("#{Rails.root}/tmp/uploader/*")
    rescue StandardError
      puts 'unable to create directory '
    end
  end

  def change_color_to_yellow
    update(color: 'health-yellow') if color != 'health-red'
    users.each(&:change_color_to_yellow)
    customer.change_color_to_yellow
  end

  def change_color_to_red
    update(color: 'health-red')
    users.each(&:change_color_to_red)
    customer.change_color_to_red
  end

  def check_product_box_threshold
    product_boxes.each(&:check_threshold)
  end

  def active_product_boxes_for_incident
    product_boxes.joins(:product).where("products.status = #{Product.statuses[:active]}")
  end
end
