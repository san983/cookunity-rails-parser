schedule_file = 'config/jobs_schedule.yml'

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
end

sidekiq_user = Rails.application.secrets.sidekiq_user
sidekiq_password = Rails.application.secrets.sidekiq_password
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == sidekiq_user && password == sidekiq_password
end
