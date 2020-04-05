class CreateIntoclassicsLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :intoclassics_links do |t|
      t.string :url
      t.references :page, foreign_key: { to_table: :intoclassics_pages }

      t.timestamps
    end
  end
end
