# Setting up Data Store API

1. Clone the repo as `git clone git@github.com:vdizzle/data_store_api.git`
2. Switch to `develop` branch as `git co develop`
3. In the project folder, create a folder `tmp` with sub-folders `pids` and `sockets`
4. Create nginx conf file (Assuming you have already installed nginx)
    In Linux, create the nginx conf file in /etc/nginx/sites-enabled.
    Use a sample nginx file here: https://gist.github.com/vdizzle/c47a30731893dd29513b
    Name the file /etc/nginx/sites-enabled/dat_store_api.conf or something similar.
5. Set the following environment variables in terminal as:
  1. `export DATABASE_NAME=<<db_name>>`
  2. `export DATABASE_USERNAME=<<db_username>>`
  3. `export DATABASE_PASSWORD=<<db_password>>`
6. If running the app first time
    1. Run `bundle`
    2. Run `bundle exec rake db:create db:migrate` 
7. Create an API key, if you already haven't, as:
    1. In irb console do the following:
        1. `bundle exec irb` (this will take you to irb console)
        2. `require './app'`
        3. `ApiKey.create!(name: 'Data Viewer')`
    3. Also, create a User (since user registration is not available on UI at this point). Do the following in the irb console
        1. `bundle exec irb` (this will take you to irb console)
        2. `require './app'`
        3. `u = User.new`
        4. `u.email = 'someemail@domain.com'`
        5. `u.password = 'some-password'`
        6. `u.save!`
8. Copy the 'key' for the new API Key created, which will be used in Data Viewer (Read Data Viewer README)
9. Go to project path, and run the following
    1. `bundle`. Also 
    2. `foreman start`
