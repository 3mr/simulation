bundle install --deployment --without development test
bundle exec rake db:migrate RAILS_ENV=production
service apache2 restart
