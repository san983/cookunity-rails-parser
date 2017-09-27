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
if Sidekiq.server?
  # Runs every each minute by default if ORDERS_COLLECT_JOB_SCHEDULE is not set
  # Runs once a day by default if DELETE_OLD_ORDERS_JOB_SCHEDULE is not set
  schedule = {
    'orders_collect_1' =>
    {
      'cron' => ENV.fetch('ORDERS_COLLECT_JOB_SCHEDULE', '* * * * * *'),
      'class' => 'OrdersCollectJob',
      'queue' => 'orders_collect',
      'args' => '[1]'
    },
    'orders_collect_2' =>
    {
      'cron' => ENV.fetch('ORDERS_COLLECT_JOB_SCHEDULE', '* * * * * *'),
      'class' => 'OrdersCollectJob',
      'queue' => 'orders_collect',
      'args' => '[2]'
    },
    'orders_collect_3' =>
    {
      'cron' => ENV.fetch('ORDERS_COLLECT_JOB_SCHEDULE', '* * * * * *'),
      'class' => 'OrdersCollectJob',
      'queue' => 'orders_collect',
      'args' => '[3]'
    },
    'delete_orders_collect' =>
    {
      'cron' => ENV.fetch('DELETE_OLD_ORDERS_JOB_SCHEDULE', '0 0 * * * *'),
      'class' => 'DeleteOldOrdersJob',
      'queue' => 'delete_orders_collect'
    }
  }
  Sidekiq::Cron::Job.load_from_hash(schedule)
end
