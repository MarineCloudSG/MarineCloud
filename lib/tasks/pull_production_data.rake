namespace :db do
  desc 'Pulls and obfuscates production data'
  task :pull_production, %i[heroku_db_name] => :environment do |_task, args|
    # rubocop:disable Layout/LineLength
    commands = []
    commands << "heroku pg:backups:capture #{args.fetch('heroku_db_name') { 'DATABASE' }} --app smarter-coach"
    commands << 'heroku pg:backups:download --app smarter-coach'
    commands << 'pg_restore --verbose --data-only --no-acl --no-owner -h localhost -U postgres --port 5432 --dbname marine_cloud_development latest.dump'
    # commands << 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres --port 5432 --dbname marine_cloud_development latest.dump'
    commands << 'rm latest.dump'
    # rubocop:enable Layout/LineLength

    commands.each { |command| `#{command}` }
  end
end
