# Sidekiq Portal Status Configuration
sidekiq_user = Rails.application.secrets.sidekiq_user
sidekiq_password = Rails.application.secrets.sidekiq_password
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == sidekiq_user && password == sidekiq_password
end

# Sidekiq Redis Server Configuration
Sidekiq.configure_server do |config|
  config.redis = { size: 27, url: ENV.fetch('REDISCLOUD_URL') { 'redis://0.0.0.0:6379' } }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 27, url: ENV.fetch('REDISCLOUD_URL') { 'redis://0.0.0.0:6379' } }
end

# Sidekiq Schedule Configuration
schedule_file = 'config/jobs_schedule.yml'
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
end
