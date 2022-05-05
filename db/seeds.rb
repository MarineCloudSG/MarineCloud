# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  unless User.where(email: 'user@example.com').exists?
    user = User.new(
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    # user.skip_confirmation!
    user.save!
  end

  unless AdminUser.where(email: 'admin@example.com').exists?
    admin_user = AdminUser.new(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    # user.skip_confirmation!
    admin_user.save!
  end

  { 'BOILER' => 100,
    'BOILER 1' => 101,
    'BOILER 2' => 102,
    'COMPOSITE BOILER' => 103,
    'FEEDWATER' => 200,
    'ENGINE COOLING' => 300,
    'HT COOLING' => 301,
    'LT COOLING' => 302 }.each do |name, code|
    System.where(name: name, code: code).first_or_create!
  end

  # TODO: Update final values
  {
    'P-Alkalinity' => { unit: '', csv_code: 1 },
    'M-Alkalinity' => { unit: '', csv_code: 2 },
    'Phosphate' => { unit: '', csv_code: 3 },
    'Chloride' => { unit: 'mg/l', csv_code: 101 },
    'Sulfite' => { unit: '', csv_code: 5 },
    'Deha' => { unit: '', csv_code: 6 },
    'Hydrazine' => { unit: '', csv_code: 7 },
    'Copper' => { unit: '', csv_code: 8 },
    'Iron' => { unit: '', csv_code: 9 },
    'PH' => { unit: '', csv_code: 330 },
    'Conductivity' => { unit: 'mg/l CaCO3', csv_code: 190 },
    'Hardness' => { unit: 'mg/l CaCO3', csv_code: 200 },
    'Nitrite' => { unit: '', csv_code: 13 },
    'Sulphate' => { unit: '', csv_code: 14 },
    'Nitrate' => { unit: '', csv_code: 15 }
  }.each do |name, data|
    parameter = Parameter.where(name: name, unit: data[:unit]).first_or_create!
    ParameterSource.where(parameter: parameter, source: :photometer_csv, code: data[:csv_code]).first_or_create!
  end

  last_month = (Date.current - 1.month).all_month

  {
    'Dexie' => 'Stark Industries',
    'Maverick' => 'Stark Industries',
    'Ironboat' => 'Stark Industries',
    'Battie' => 'Wayne Enterprise'
  }.each do |vessel_name, group_name|
    group = VesselGroup.where(name: group_name).first_or_create!
    vessel = group.vessels.where(name: vessel_name).first_or_initialize

    vessel.email = "#{vessel_name.parameterize.underscore}@#{group.name.parameterize.underscore}.dev"
    vessel.chemical_program = Vessel.chemical_programs.values.sample
    vessel.company_name = group_name
    vessel.flag = 'Jolly Roger'
    vessel.save!

    vessel.systems << System.all.sample(3) unless vessel.systems.exists?

    next if vessel.vessel_system_parameters.exists?

    vessel.vessel_systems.each do |vessel_system|
      Parameter.all.sample(5).each do |parameter|
        system_parameter = VesselSystemParameter.create!(
          vessel_system: vessel_system,
          parameter: parameter,
          min_satisfactory: [10, 20, 50, 100, 200].sample,
          max_satisfactory: [250, 300, 500, 1000].sample
        )

        parameter_digits = rand(0..3)
        parameter_margin = rand(0.0..[system_parameter.min_satisfactory, system_parameter.max_satisfactory].min)
        last_month.each do |date|
          min_val = system_parameter.min_satisfactory - rand(0.0..parameter_margin)
          max_val = system_parameter.max_satisfactory + rand(0.0..parameter_margin)
          value = rand(min_val..max_val).round(parameter_digits)
          Measurement.create!(taken_at: date, value: value, vessel_system_parameter: system_parameter)
        end
        MeasurementsImport.create!(vessel: vessel, filename: 'foo.xlsx')
      end
    end
  end
end
