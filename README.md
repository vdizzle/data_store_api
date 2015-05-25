# Setting up Data Store API

1. Clone the repo as `git@github.com:vdizzle/data_store_api.git`
2. In the project folder, create a folder `tmp` with sub-folders `pids` and `sockets`
3. Create nginx conf file (Assuming you have already installed nginx)
    In Linux, create the nginx conf file in /etc/nginx/sites-enabled.
    Use a sample nginx file here: https://gist.github.com/vdizzle/c47a30731893dd29513b
    Name the file /etc/nginx/sites-enabled/dat_store_api.conf or something similar.
4 Set the following environment variables in terminal as:
  1. $ export DATABASE_NAME=<<db_name>>
  2. $ export DATABASE_USERNAME=<<db_username>>
  3. $ export DATABASE_PASSWORD=<<db_password>>
5. Go to project path, and run the following
    1. `bundle`. Also run `bundle exec rake db:migrate` (if running the app first time)
    2. `foreman start`
