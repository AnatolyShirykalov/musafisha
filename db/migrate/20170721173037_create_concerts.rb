class CreateConcerts < ActiveRecord::Migration[5.1]
  include Migrations
  def change
    create_table :concerts do |t|
      t.datetime :date
      t.string :row
      t.string :url
      t.string :site
      t.string :alltext
      t.references :hall, foreign_key: true
      t.attachment :image
      t.string :program
      t.string :description
      t.tsvector :tsv_body

      t.timestamps
    end

    add_index :concerts, :tsv_body, using: 'gin'

    trigger("concerts")
  end
end
