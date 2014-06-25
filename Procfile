web: bundle exec passenger start -p $PORT --max-pool-size 2
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml