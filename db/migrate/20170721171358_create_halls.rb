class CreateHalls < ActiveRecord::Migration[5.1]
  def change
    create_table :halls do |t|
      t.string :name
      t.string :url
      t.attachment :icon
      t.references :city

      t.timestamps
    end
  end
end
