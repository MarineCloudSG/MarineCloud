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
    System.where(name: name, code: code).first_or_create
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
    Parameter.where(label: name, code: code).first_or_create
  end
end
