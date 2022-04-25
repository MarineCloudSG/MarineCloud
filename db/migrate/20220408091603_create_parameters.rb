class CreateParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :parameters do |t|
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
