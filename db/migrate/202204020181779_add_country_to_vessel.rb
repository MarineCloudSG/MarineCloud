class AddCountryToVessel < ActiveRecord::Migration[7.0]
  def change
    default_country = Country.create!(name: 'Unknown')
    add_reference :vessels, :country, null: true, foreign_key: true
    Vessel.all.each do |v|
      v.country = default_country
      v.save!
    end
    change_column_null :vessels, :country_id, false
  end
end
