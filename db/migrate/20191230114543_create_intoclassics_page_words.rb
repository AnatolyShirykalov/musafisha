class CreateIntoclassicsPageWords < ActiveRecord::Migration[6.0]
  def change
    create_table :intoclassics_page_words do |t|
      t.references :page, foreign_key: { to_table: :intoclassics_pages }
      t.references :word, foreign_key: { to_table: :intoclassics_words }
      t.index %i[word_id page_id], unique: true
    end
  end
end
