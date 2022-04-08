# MarineCloud


## Setting up application locally

- Ensure you have docker installed
- Ensure you are using the correct ruby version (look into `.ruby-version` for reference)
- When using rvm: `rvm use --create 3.0.3@marine-cloud`

- Then, in project directory
    - get `development.key` from other devs (eg. Stevo) and move it into `config/credentials`
      - you can generate new credentials file instead if you want, but this is not advised
      - look [here](https://guides.rubyonrails.org/security.html#environmental-security) for more details
    - `docker compose up` - runs PostgreSQL and Redis
    - `cp config/database.yml.example config/database.yml` - instantiates local database configuration
    - `cp .env.example .env` - instantiates local ENV variables
    - `bundle install` - installs all necessary gems (libraries)
    - `rails db:create db:schema:load` - creates DB and loads the most recent DB structure
    - `rails db:seed` - to seed database with initial data
    - `yarn install` - install YARN packages
    - `gem install foreman` - required to execute Procfiles (for the command below)
    - `bin/dev` - runs application server, sidekiq, stripe daemon and CSS/JS builds
    - goto [localhost:3000](http://localhost:3000) to open up application
      - u: `admin@example.com`
      - p: `password`

# Editing credentials

- `EDITOR="vi" bin/rails credentials:edit --environment=development`
- `EDITOR="vi" bin/rails credentials:edit`

# Stack

- Ruby on Rails
  - ViewComponents
- Tailwind
  - TailwindUI
- AWS
  - S3
- Heroku
