# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# env :GEM_PATH, '/usr/local/bundle' # defines where to find rake command
set :output, 'log/cron.log' # log location

# We override rake job type, as we don't want envrinoment specific task
job_type :rake, "cd :path && bundle exec rails :task --silent :output"

ENV.each_key do |key|
  env key.to_sym, ENV[key]
end


# runs every day at 12:00am
every :day, at: '12:00am' do
  rake "script:check_expiring_products"
  rake "script:expire_product_boxes"
  rake "script:database_views_refresh"
end