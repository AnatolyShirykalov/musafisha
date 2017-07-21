class CreateConcerts < ActiveRecord::Migration[5.1]
  def change
    create_table :concerts do |t|
      t.datetime :date
      t.string :row
      t.string :url
      t.string :site
      t.references :hall, foreign_key: true
      t.attachment :image
      t.string :program
      t.string :description

      t.timestamps
    end
  end
end
