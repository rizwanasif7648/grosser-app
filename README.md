# README

# w3 App

## Getting Started

Make sure you have docker and docker-compose installed.
- Rename `.env.example` to `.env` to get started (Take missing secrets from your peer)
- Run `docker-compose up -d` to start the app.
- Run this command to install the bundle and sync changes to Gemfile.lock `docker-compose run --rm app bundle install`
- Run this command after updating the bunlde file or any config file `docker-compose up --build`
- Run this command to setup the database `docker-compose run --rm app bin/rake db:setup`


## Logs
- Run this command to see logs of app `docker-compose logs -f app`

## Updating

- Run this command to migrate the database `docker-compose run --rm app bundle exec rake db:migrate`

## Bash & Rails console

To enter the bash and rails console type this command `docker-compose exec app bash` and inside the container just type `bin/rails c`


The app should be running at (http://localhost:3000)[http://localhost:3000]

## Exit 
- Run this command to exit or close the app `docker-compose down`

## Theme Used
   (Bootstrap SB Admin 2)[https://startbootstrap.com/themes/sb-admin-2/]

This README would normally document whatever steps are necessary to get the
application up and running.

