# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
