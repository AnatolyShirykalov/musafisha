class CreateIntoclassicsPages < ActiveRecord::Migration[6.0]
  def change
    create_table :intoclassics_pages do |t|
      t.string :title
      t.string :h1
      t.string :slug
      t.text :content
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
