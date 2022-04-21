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
    'LT COOLING' => 302
  }.each do |name, code|
    System.where(name: name, code: code).first_or_create!
  end

  # TODO: Codes for sure will need to be amended
  {
    'P-Alkalinity' => 'p_alkalinity',
    'M-Alkalinity' => 'm_alkalinity',
    'Phosphate' => 'phosphate',
    'Chloride' => 'chloride',
    'Sulfite' => 'sulfite',
    'Deha' => 'deha',
    'Hydrazine' => 'hydrazine',
    'Copper' => 'copper',
    'Iron' => 'iron',
    'PH' => 'ph',
    'Conductivity' => 'conductivity',
    'Hardness' => 'hardness',
    'Nitrite' => 'nitrite',
    'Sulphate' => 'sulphate',
    'Nitrate' => 'nitrate'
  }.each do |name, code|
    unit = ['mg/l Cl2', 'mg/l CaCO3', 'uS/cm', 'pH', 'mg/L', 'mmol/L'].sample
    Parameter.where(label: name, code: code, unit: unit).first_or_create!
  end

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
    vessel.save!

    unless vessel.systems.exists?
      vessel.systems << System.all.sample(3)
    end

    unless vessel.vessel_system_parameters.exists?
      vessel.vessel_systems.each do |vessel_system|
        Parameter.all.sample(5).each do |parameter|
          VesselSystemParameter.create!(
            vessel_system: vessel_system,
            parameter: parameter,
            min_satisfactory: [10, 20, 50, 100, 200].sample,
            max_satisfactory: [250, 300, 500, 1000].sample
          )
        end
      end
    end
  end
end
