source: https://auth0.com/blog/ruby-on-rails-killer-workflow-with-docker-part-1/


Install docker-compose
Create an empty Gemfile and Gemfile.lock file.

Add rails to Gemfile:
```
  source 'https://rubygems.org'
  gem 'rails', '~>5.2'
```

Run:
```
docker-compose up --build
```
to build the docker image and run a container.

It will error since there's no rails app.
Run:
```
docker-compose run --user $(id -u):$(id -g) app rails new . --force --database=postgresql --skip-bundle
```
to scaffold the initial Rails app. Since you have a volume mapped to your local directory, all the files that rails created should be available for you to edit.

Change the config/database.yml to access the postgres service:
```
# ...
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  user: postgres
  port: 5432
  password:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
# ... leave all else intact
```
rebuild your image:
```
docker-compose down
docker-compose up --build
```
If you try to access your rails app now you will be greeted with a db not found error since we didn't create it yet.
Run:
```
docker-compose exec app rails db:create
```
