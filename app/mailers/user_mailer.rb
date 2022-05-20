# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: ENV['SENDER_EMAIL']
  layout 'mailer'

  def send_signup_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Thanks for signing up for 3w')
  end

  def support(support, current_user)
    @support = support
    @user = current_user
    mail(from: "#{@user.name} < #{ENV['SENDER_EMAIL']}>", to: ENV['SENDER_EMAIL'],
         reply_to: @user.email, subject: @support.title)
  end

  def new_incident_created(incident, user, box)
    @user = user
    @box = box
    @incident = incident
    @reporter = incident.created_by
    @products = incident.product_incidents
    mail(to: @user.email,
         subject: 'Incident alert')
  end

  def product_expired(user, box, product_box)
    @user = user
    @box = box
    @product_box = product_box
    @product = product_box.product
    mail(to: @user.email,
         subject: 'Product Expiry Alert')
  end

  def product_expiring_soon(user, box, product_box)
    @user = user
    @box = box
    @product_box = product_box
    @product = product_box.product
    mail(to: @user.email,
         subject: 'Product Expiring Soon')
  end

  def product_threshold(user, box, product_box)
    @user = user
    @box = box
    @product_box = product_box
    @product = product_box.product
    mail(to: @user.email,
         subject: 'Low Stock Alert')
  end
end
