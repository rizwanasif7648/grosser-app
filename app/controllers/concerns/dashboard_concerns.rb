# frozen_string_literal: true

module DashboardConcerns
  extend ActiveSupport::Concern

  def boxes(customer, color)
    BoxesByCustomersView.find_by(id: customer.id, color: color)
  end

  def consumed_products_list(consumed_products)
    products = []
    consumed_products.each do |consumed_product|
      products << [consumed_product.name, consumed_product.quantity]
    end
    @products = products
  end

  def consumed_products_by_boxes(products_by_boxes)
    products_by_box = []
    products_by_boxes.each do |product_by_box|
      products_by_box << [product_by_box.name, product_by_box.quantity]
    end
    @products_by_box = products_by_box
  end

  def consumed_products_table(products_by_boxes)
    products_by_box = []
    products_by_boxes.each do |product_by_box|
      products_by_box << [product_by_box.name, product_by_box.code, product_by_box.quantity]
    end
    products_by_box
  end

  def incidents_per_boxes(modelname, customer_id, duration)
    duration = duration.to_sym
    @week_dates = modelname.pluck(duration).uniq
    incidents_per_week = modelname.where(customer_id: customer_id)
    customer_dates = incidents_per_week.pluck(duration)
    incidents_week = []
    @week_dates.each do |date|
      incidents_records = if customer_dates.include?(date)
                            modelname.find_by(customer_id: customer_id, duration => date).incidents
                          else
                            0
                          end
      incidents_week << [date, incidents_records]
    end
    @incidents_per_week = incidents_week
  end

  def incidents_boxes(duration, customer_id)
    if duration == 'week'
      time_duration = IncidentsByCustomersWeekView.pluck(:date).uniq
      products = incidents_per_boxes(IncidentsByCustomersWeekView, customer_id, 'date')
    elsif duration == 'month'
      time_duration = IncidentsByCustomersOneMonthView.pluck(:week).uniq
      products = incidents_per_boxes(IncidentsByCustomersOneMonthView, customer_id, 'week')
    elsif duration == '3 months'
      time_duration = IncidentsByCustomersThreeMonthView.pluck(:Month).uniq
      products = incidents_per_boxes(IncidentsByCustomersThreeMonthView, customer_id, 'Month')
    elsif duration == '6 months'
      time_duration = IncidentsByCustomersSixMonthView.pluck(:Month).uniq
      products = incidents_per_boxes(IncidentsByCustomersSixMonthView, customer_id, 'Month')
    end
    render status: :ok, json: { data: products, time_duration: time_duration }
  end

  def boxes_in_red(modelname, customer_id, duration)
    duration = duration.to_sym
    @red_boxes_week_dates = modelname.pluck(duration).uniq
    customer_red_boxes = modelname.where(customer_id: customer_id)
    customer_dates = customer_red_boxes.pluck(duration)
    red_boxes = []
    @red_boxes_week_dates.each do |date|
      boxes_records = if customer_dates.include?(date)
                        modelname.find_by(customer_id: customer_id, duration => date).boxes
                      else
                        0
                      end
      red_boxes << [date, boxes_records]
    end
    @boxes_in_red_week = red_boxes
  end

  def red_boxes(duration, customer_id)
    if duration == 'week'
      time_duration = BoxesInRedWeekView.pluck(:date).uniq
      products = boxes_in_red(BoxesInRedWeekView, customer_id, 'date')
    elsif duration == 'month'
      time_duration = BoxesInRedOneMonthView.pluck(:week).uniq
      products = boxes_in_red(BoxesInRedOneMonthView, customer_id, 'week')
    elsif duration == '3 months'
      time_duration = BoxesInRedThreeMonthView.pluck(:Month).uniq
      products = boxes_in_red(BoxesInRedThreeMonthView, customer_id, 'Month')
    elsif duration == '6 months'
      time_duration = BoxesInRedSixMonthView.pluck(:Month).uniq
      products = boxes_in_red(BoxesInRedSixMonthView, customer_id, 'Month')
    end
    render status: :ok, json: { data: products, time_duration: time_duration }
  end

  def consumed_products_by_date_duration(duration, customer)
    if duration == 'week'
      products = ProductsByCustomersWeekView.where(customer_id: customer.id)
    elsif duration == 'month'
      products = ProductsByCustomersOneMonthView.where(customer_id: customer.id)
    elsif duration == '3 months'
      products = ProductsByCustomersThreeMonthView.where(customer_id: customer.id)
    elsif duration == '6 months'
      products = ProductsByCustomersSixMonthView.where(customer_id: customer.id)
    end
    products_by_duration = consumed_products_table(products)
    render status: :ok, json: { data: products_by_duration }
  end

  def consumed_products_boxes_by_date_duration(duration, box_id)
    if duration == 'week'
      products = ProductsByBoxesWeekView.where(box_id: box_id)
    elsif duration == 'month'
      products = ProductsByBoxesOneMonthView.where(box_id: box_id)
    elsif duration == '3 months'
      products = ProductsByBoxesThreeMonthView.where(box_id: box_id)
    elsif duration == '6 months'
      products = ProductsByBoxesSixMonthView.where(box_id: box_id)
    end
    products_by_duration = consumed_products_table(products)
    render status: :ok, json: { data: products_by_duration }
  end
end
