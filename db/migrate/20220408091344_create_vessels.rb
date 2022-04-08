class CreateVessels < ActiveRecord::Migration[7.0]
  def change
    create_table :vessels do |t|
      t.string :name
      t.references :vessel_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
