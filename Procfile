web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -q orders_collect, 1 -q delete_orders_collect
