#!/bin/sh

# ruby has to be installed here already
# Install needed ruby dependencies (gems)
gem install rails --version 2.3.5
gem install rack --version 1.0.1
gem install postgres-pr
gem install i18n --version 0.4.2

# Install needed packages
pacman -S redmine ruby-rmagick

# Create database users
psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'redmine' NOINHERIT VALID UNTIL 'infinity'" postgres postgres
psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' TEMPLATE=template0 OWNER=redmine" postgres postgres

# the following command can only be installed after a 
# re-initialization of the environment,
# please logout and login again


# Initialize redmine
rake generate_session_store
RAILS_ENV=production rake db:migrate

# it will ask for a language
#RAILS_ENV=production rake redmine:load_default_data

# try it out:
#ruby script/server webrick -e production
# http://localhost:3000

ruby script/plugin install http://r-labs.googlecode.com/svn/trunk/plugins/redmine_hudson/

rake db:migrate_plugins RAILS_ENV=production
