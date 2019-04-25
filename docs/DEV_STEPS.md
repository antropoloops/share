# Cassette

## 1. Project setup with docker database

### Create an empty Rails project

```bash
gem install rails
rails new cassette --database=postgresql --skip-coffee
cd cassette
```

Add gems to Gemfile:

```
gem 'dotenv-rails', groups: [:development, :test] # add it to the top of your gem file
```

And run `bundle install`

### Download and start the postgresql database

```
docker pull postgres
mkdir -p $HOME/docker/volumes/postgres/cassette
docker run --rm -d --name pg-cassette \
  -e POSTGRES_PASSWORD=docker -p 5432:5432 \
  -v $HOME/docker/volumes/postgres/cassette:/var/lib/postgresql/data postgres
touch .env
echo '.env' >> .gitignore
```

Add into `package.json` scripts:

```json
  "scripts": {
    "db:start": "docker run --rm --name pg-cassette -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres/cassette:/var/lib/postgresql/data postgres"
  },
```

### Configure using .env file

```
touch .env
echo '.env' >> .gitignore
```

```ruby
# config/initializers/dotenv.rb

Dotenv.require_keys("SERVICE_APP_ID", "SERVICE_KEY", "SERVICE_SECRET")
```

At `.env`:

```
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=docker
```

## Configure database

At `config/database.yml`:

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>

development:
  <<: *default
  database: cassette_development

test:
  <<: *default
  database: cassette_test

production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
```

And create the database by running: `rails db:create`

### Add UUID support to postgresql

```bash
rails g migration enable_uuid
```

Add the following at `db/migrate/?????????????_enable_uuid.rb`:

```ruby
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
```

And migrate:

```
rake db:migrate
```

### Test everything works

We're goint to test everything by creating a new controller:

```bash
rails g controller static --no-helper --no-assets
```

Edit `app/controllers/status_controller.rb` to be:

```ruby
class StatusController < ApplicationController
  def show
    render plain: 'Ok'
  end
end
```

Setup a root route at `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  root to: 'status#show'
end
```

Connect to `http://localhost:3000/` and you should see "Ok".

## 2. Setup devise

### Install devise

```
gem 'devise'
bundle install
spring stop
rails generate devise:install
```

Edit some files:

```ruby
# At config/environments/development.rb add:
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

# At app/views/layouts/application.html.erb change `<body>`
  <body>
    <% if flash[:notice] %>
      <div class="notice"><%= notice %></div>
    <% elsif flash[:alert] %>
      <div class="alert"><%= alert %></div>
    <% end %>

    <%= yield %>
  </body>
```

### Create users

```
rails generate devise User
```

Edit migration to use `uuid`:

```ruby
# Instead of:
#   create_table :users do |t|
# Should be:
    create_table :users, id: :uuid do |t|
    ...
    end
```

And migrate: `rake db:migrate`

## 3. Shrine

### Run minio on docker

```
docker pull minio/minio
mkdir -p $HOME/docker/volumes/minio/cassette/data
docker run --rm -d --name minio-cassette -p 9000:9000 \
  -e "MINIO_ACCESS_KEY=minio-access-key" \
  -e "MINIO_SECRET_KEY=minio-secret-key" \
  -v $HOME/docker/volumes/minio/cassette/data:/data \
  -v $HOME/docker/volumes/minio/cassette:/root/.minio \
  minio/minio server /data

# Check if the container is running
docker ps
```

Test that it works by connecting at: http://127.0.0.1:9000/minio/login

### Install and configure shine with s3 (minio)

Install gems:

```
gem 'image_processing', '~> 1.0'
gem 'shrine', '~> 2.0'
gem 'aws-sdk-s3', '~> 1.2'
```

Add a new file `config/initializers/shrine.rb`:

```ruby
require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :pretty_location
Shrine.plugin :backgrounding

Shrine.plugin :logging
Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('tmp', prefix: 'uploads/cache'),
  store: Shrine::Storage::S3.new(bucket: ENV['S3_BUCKET'],
                                  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                  region: ENV['AWS_REGION'])
}
```

Add the following lines to .env:

```
S3_BUCKET=cassette-development
AWS_ACCESS_KEY_ID=minio-access-key
AWS_SECRET_ACCESS_KEY=minio-secret-key
AWS_REGION=eu-west-1
```

### Create a Shrine uploader

Create a new file `app/uploaders/logo_uploader.js`

```ruby
class LogoUploader < Shrine

  plugin :processing
  plugin :versions
  plugin :validation_helpers

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:thumb] = pipeline.resize_to_limit!(200, 200)
      versions[:small] = pipeline.resize_to_limit!(400, 400)
    end

    versions
  end

  Attacher.validate do
    validate_max_size 2.megabytes
    validate_extension_inclusion %w[jpg jpeg png gif]
  end

end
```

### Create model

```bash
spring stop
rails generate scaffold project title:string logo_data:string --no-assets --no-helper
# Edit project model migration to use `id: :uuid`
rake db:migrate
```

At `app/controller/projects_controller.rb` add:

```ruby
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  ...
end
```

At `app/models/project.rb`:

```ruby
class Project < ApplicationRecord
  include LogoUploader[:logo]
end
```

### Clear cache

https://www.ctolib.com/shrine.html#articleHeader25

```ruby
# S3 storage
s3 = Shrine.storages[:cache]
s3.clear!
```
