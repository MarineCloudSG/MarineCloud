class CreateImportLog < ActiveRecord::Migration[7.0]
  def change
    create_table :import_logs do |t|
      t.references :measurements_import, null: false, foreign_key: true
      t.references :vessel, null: false, foreign_key: true
      t.text :msg

      t.timestamps
    end
  end
end
