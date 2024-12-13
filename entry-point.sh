#!/bin/sh
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rerun --background -- ruby main.rb