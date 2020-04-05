class CreateIntoclassicsWords < ActiveRecord::Migration[6.0]
  def change
    create_table :intoclassics_words do |t|
      t.string :content

      t.index :content

    end
  end
end
