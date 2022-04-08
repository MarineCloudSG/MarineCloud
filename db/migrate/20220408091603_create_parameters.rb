class CreateParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :parameters do |t|
      t.string :label
      t.string :code
      t.integer :system

      t.timestamps
    end
  end
end
