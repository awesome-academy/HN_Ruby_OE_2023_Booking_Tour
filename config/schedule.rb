# config/schedule.rb

# Set the output path for cron log
set :output, "./log/cron.log"

# Schedule a task to run every minute
every 1.minute do
  runner "puts 'Run file'"
end
