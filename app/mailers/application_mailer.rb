# frozen_string_literal: true

# EMail Helper for sending email
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
