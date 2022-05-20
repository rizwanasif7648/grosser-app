class AddQrcodeUrlToBox < ActiveRecord::Migration[5.2]
  def change
  	add_column :boxes, :qrcode_url, :string
  end
end
