# Set up of data_store_api

* Clone the repo as 
```bash
git clone https://github.com/vdizzle/data_store_api.git
```

* Switch to develop branch as 
```bash
git checkout develop
```

* In the project folder, create a folder **tmp** with sub-folders **pids** and **sockets**.
  * Create another folder **log** 
  * Run these commands to grant permission to write on the folder
```bash
sudo chown -R ovaladmin ./tmp
sudo chown -R ovaladmin ./log
```

###Configure nginx 
* Create nginx conf file (Assuming you have already installed nginx) 
  * Linux, create the nginx conf file in /etc/nginx/sites-enabled.
  * Use a sample nginx file here: [https://gist.github.com/vdizzle/c47a30731893dd29513b] 
  * Name the file **/etc/nginx/sites-enabled/dat_store_api.conf** or something similar.
  * Restart nginx server
```bash
sudo service nginx restart
```

###Configure PostgreSQL (9.3)
* Bring up postgres console. Default user is postgres, password blank.
```bash
sudo -u postgres psql template1
```
* In the postgres console, change the password for the user postgres.
```SQL
ALTER USER postgres with encrypted password 'postgres';
```

* Edit pg_hba.conf
```bash
sudo vim /etc/postgresql/9.1/main/pg_hba.conf
```
  * For the first row i.e for user postgres, change the value of last column to 'md5' (without quotes)
  * For all other rows, change the value of last column to 'trust'

* Restart Postgres
```bash
sudo /etc/init.d/postgresql restart
```

* Create user for the Data API app
```sql
sudo -u postgres psql postgres
CREATE USER data_api WITH PASSWORD 'data_api';
ALTER USER data_api WITH SUPERUSER;

CREATE DATABASE data_api_db ENCODING 'UTF8' OWNER data_api; 
```

* Try logging in as the user 
```bash
psql --username data_api --password data_api_dev
```

###Run the code

* First go into a tmux session to preserve env variable
```bash
tmux new -s data_api
```

* Set the following environment variables in terminal as
```bash
export DATABASE_NAME=<<db_name>>
export DATABASE_USERNAME=<<db_username>>
export DATABASE_PASSWORD=<<db_password>>
```

* If running the app first time
```bash
gem install bundler
bundle
bundle exec rake db:create db:migrate
```

* Create an API key, if you already haven't by foing to the irb console as:
```bash
bundle exec irb 
```
* Run the following commands to set up the API key and user
```ruby
require './app'
ApiKey.create!(name: 'Data Viewer')

# Also, create a User
u = User.new
u.email = 'someemail@domain.com'
u.password = 'some-password'
u.save!
```

* Copy the 'key' for the new API Key created, which will be used in Data Viewer
    * Also the API URL will be **http://domain:port/**
    * Here domain and port are as defined in the nginx conf file

* Go to project path, and run the following
```bash
bundle
foreman start
```

* Check the following url to see it it's working correctly
```bash
http://localhost:8020/ha-check
```
