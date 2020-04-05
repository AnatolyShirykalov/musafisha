class CreateIntoclassicsPageComposers < ActiveRecord::Migration[6.0]
  def change
    create_table :intoclassics_page_composers do |t|
      t.references :page, foreign_key: { to_table: :intoclassics_pages }
      t.references :composer, foreign_key: false
      t.index %i[composer_id page_id], unique: true

      t.timestamps
    end
  end
end
