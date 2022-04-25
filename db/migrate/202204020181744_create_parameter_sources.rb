class CreateParameterSources < ActiveRecord::Migration[7.0]
  def change
    create_table :parameter_sources do |t|
      t.integer :source
      t.string :code
      t.references :parameter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
