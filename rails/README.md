source: https://auth0.com/blog/ruby-on-rails-killer-workflow-with-docker-part-1/
1. Make a copy of the project-starterkits/rails folder
2. Create your desired Gemfile and Gemfile.lock file (maybe include a sample one?)
3. run docker-compose up --build -t "some name for the image"
4. There will be an error since there's no rails app yet, press CTRL+C to stop the container
5. Run the rails new command against the "web" service defined in docker-compose.yml (see below).
6. Run docker-compose-up to launch all services, or docker run to run specific ones
7. Update the config/database.yml with credentials to connect ro the "db" service
8. Run rake db:create to build the db

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
docker-compose run --user $(id -u):$(id -g) [containerName] rails new . --force --database=postgresql --skip-bundle
```
to start the "web" service defined in docker-compose.yml and scaffold the initial Rails app. Since you have a volume mapped to your local directory, all the files that rails created should be available for you to edit.

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
docker-compose run web rails db:create
```

Note: docker-compose exec vs docker-compse run, exec will execute the commands in an existing (already running) container
