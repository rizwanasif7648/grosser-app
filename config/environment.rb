# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options = { :host =>  ENV.fetch('HOST', 'http://localhost:3000')}
ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey',
    :password =>  ENV.fetch('SENDGRID_API_KEY', ''),
    :domain => '3Whealthcare.ca',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}
