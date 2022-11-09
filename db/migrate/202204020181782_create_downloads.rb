class CreateDownloads < ActiveRecord::Migration[7.0]
  def change
    create_table :downloads do |t|
      t.text :title
      t.integer :order
      t.timestamps
    end
  end
end
