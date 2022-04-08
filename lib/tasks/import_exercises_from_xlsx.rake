# rubocop:disable all
#
# To load production data:
# DATABASE_URL=$(heroku config:get DATABASE_URL -a smarter-coach) rake "marine_cloud:import_exercises_xlsx[baza.xlsx]"

namespace :marine_cloud do
  desc 'Imports exercises list from XLSX'
  task :import_exercises_xlsx, %i[filename] => :environment do |_task, args|
    if ENV['DATABASE_URL'].present?
      puts "Establishing connection with #{ENV['DATABASE_URL']}"
      ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    end

    workbook = RubyXL::Parser.parse(args.fetch(:filename))
    exercises = ExercisesWorkbook.new(workbook['Główna, nadrzędna baza ćwiczeń'])

    exercises.each do |exercise|
      begin
        record = Exercise.where(name: exercise.name).first_or_initialize
        record.assign_attributes(
          youtube_url: exercise.youtube_url,
          plane_horizontal: exercise.plane.nil? ? false : exercise.plane.include?('horizontal'),
          plane_vertical: exercise.plane.nil? ? false : exercise.plane.include?('vertical')
        )
        record.save!

        if exercise.muscle_groups.present?
          exercise.muscle_groups.each do |muscle_group_code|
            muscle_group = MuscleGroup.where(code: muscle_group_code).first_or_create!
            record.muscle_groups << muscle_group
            record.save!
          end
        end

        if exercise.default_tempo
          tempo = Parameters::Tempo.where(exercise_id: record.id).first_or_initialize
          tempo.default = exercise.default_tempo
          tempo.save!
        end

        if exercise.default_reps
          reps = Parameters::Repetitions.where(exercise_id: record.id).first_or_initialize
          reps.default = exercise.default_reps
          reps.save!
        end

        if exercise.default_weight
          reps = Parameters::Weight.where(exercise_id: record.id).first_or_initialize
          reps.default = exercise.default_weight
          reps.save!
        end

        puts "#{exercise.name} upserted..."
      rescue => e
        puts "Failed when importing", exercise
        raise e
      end
    end

    puts 'Exercise import finished!'
  end
end
# rubocop:enable all
