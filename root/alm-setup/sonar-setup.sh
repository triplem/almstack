#!/bin/sh
pacman -S sonar

## Sonar is available on localhost:9000

# Create database users
psql -c "CREATE ROLE sonar LOGIN ENCRYPTED PASSWORD 'sonar' NOINHERIT VALID UNTIL 'infinity'" postgres postgres
psql -c "CREATE DATABASE sonar WITH ENCODING='UTF8' TEMPLATE=template0 OWNER=sonar" postgres postgres


