class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.references :parameter, null: false, foreign_key: true
      t.references :vessel, null: false, foreign_key: true
      t.references :parameter_source, null: true, foreign_key: true
      t.datetime :taken_at
      t.string :value

      t.timestamps
    end
  end
end
