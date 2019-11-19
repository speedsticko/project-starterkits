source: https://auth0.com/blog/ruby-on-rails-killer-workflow-with-docker-part-1/
updated with: https://rubyinrails.com/2019/03/29/dockerify-rails-6-application-setup/

The instructions are a little weird because we first build a container, expect and error, run a rails command, then re-build the container again. The reason is that we want to make the layering of intermediate images efficient. We copy the Gemfile late in the Dockerfile so that it only does a re-build when the Gemfile changes and not for every little file change (or at least that's what I think it's trying to do). Another issue is that the "docker-compose run" command will run as the root user by default so it might be strange how sometimes it will say gems can't be found. In that case the gems were likely installed by a different user so make sure you perform operations under a consistent user. And finally, use "docker-compose logs" to see the logs emitted by your docker containers. 

1. Make a copy of the project-starterkits/rails folder
2. Modify the Gemfile and Gemfile.lock file if you want a different rails version
3. Build the container by running: docker-compose up --build  or docker-compose build
It will build the "db" and "web" containers. The "web" container will fail because one of the steps is to start the rails server but there's no app yet. 
4. There will be an error since there's no rails app yet, press CTRL+C to stop the container
5. Run the "rails new" command against the "web" service defined in docker-compose.yml (see below).
6. Run docker-compose-up to launch all services, or docker run to run specific commands
7. Update the config/database.yml with credentials to connect ro the "db" service
8. Run rake db:create to build the db

In other words, ...

Install docker-compose
Create an empty Gemfile and Gemfile.lock file.

Add rails to Gemfile:
```
  source 'https://rubygems.org'
  gem 'rails', '~>6.0.1'
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

Note: docker-compose exec vs docker-compose run, exec will execute the commands in an existing (already running) container
