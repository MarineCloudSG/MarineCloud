class CreateParameterRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :parameter_recommendations do |t|
      t.references :parameter, null: false, foreign_key: true
      t.decimal :value_min
      t.decimal :value_max
      t.string :message

      t.timestamps
    end
  end
end
