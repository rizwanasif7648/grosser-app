# frozen_string_literal: true

# Reports Helper for shared functions for Reports Module
module ReportsHelper
  def get_product_box_count(box_id, product_id)
    ProductBox.where(box_id: box_id, product_id: product_id)&.last&.count
  end
end
