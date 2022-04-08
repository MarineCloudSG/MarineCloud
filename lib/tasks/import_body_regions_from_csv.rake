# rubocop:disable all
#
# To load production data:
# DATABASE_URL=$(heroku config:get DATABASE_URL -a smarter-coach) rake "marine_cloud:import_body_regions_csv[muscle_groups.csv]"
require 'csv'

namespace :marine_cloud do
  desc 'Imports body regions list from csv'
  task :import_body_regions_csv, %i[filename] => :environment do |_task, args|
    if ENV['DATABASE_URL'].present?
      puts "Establishing connection with #{ENV['DATABASE_URL']}"
      ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    end

    body_regions = CSV.read(args.fetch(:filename), headers: true)

    body_regions.each do |row|
      body_region = "#{row['Group']} #{row['Area']}".strip.downcase.gsub(' ', '_')
      muscle_group_from_csv = row['en'].downcase.gsub(/[^a-zA-Z ]/,'').squish.gsub(' ', '_')

      begin
        record = BodyRegion.where(code: body_region).first_or_create!
        muscle_group = MuscleGroup.where(code: muscle_group_from_csv).first_or_create!
        unless record.muscle_group_ids.include?(muscle_group.id)
          record.muscle_groups << muscle_group
          record.save!
          puts "#{muscle_group_from_csv} for #{body_region} inserted..."
        end

      rescue => e
            puts "Failed when importing", body_region
            raise e
      end
    end

    puts 'Body regions import finished!'
  end
end
# rubocop:enable all
