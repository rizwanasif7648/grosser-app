# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  code          :string
#  name          :string           not null
#  description   :text
#  category      :string
#  brand         :string
#  asset_type    :string
#  is_expirable  :boolean          default(TRUE)
#  photo         :string
#  status        :integer          default("active")
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  qrcode_url    :string
#
class Product < ApplicationRecord
  include ProductValidations
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  has_many :product_boxes, dependent: :destroy
  has_many :boxes, through: :product_boxes
  has_many :product_incidents, dependent: :destroy
  mount_uploader :qrcode_url, PictureUploader

  enum status: %w[inactive active archived]

  after_create :generate_qr_code

  mount_uploader :photo, PictureUploader
  scope :possible_products_list_for_box, ->(box) { where.not(id: box.products.pluck(:id)) }
  scope :order_by_name, -> { order(:name) }
  default_scope do
    where.not(status: 'archived')
  end

  after_initialize do
    self.status = nil if new_record?
  end

  def photo_src
    photo_url.present? ? photo_url(:square) : 'no_image'
  end

  def photo_name
    photo_url.present? ? photo_url.split('/').last : ''
  end

  def generate_qr_code
    product = self
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
      product.qrcode_url = src_file
      product.save!
      FileUtils.rm_rf Dir.glob("#{Rails.root}/tmp/uploader/*")
    rescue StandardError
      puts 'unable to create directory '
    end
  end

  def box(id)
    product_boxes.find_by(box_id: id)
  end

  def used(id)
    box(id).count - box(id).remaining
  end
end
