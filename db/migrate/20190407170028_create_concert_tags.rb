class CreateConcertTags < ActiveRecord::Migration[5.2]
  def change
    create_table :concert_tags do |t|
      t.references :concert, foreign_key: true
      t.bigint :composer_id
      t.bigint :piece_id
      t.bigint :performer_id

      t.timestamps
    end
    add_index :concert_tags, :composer_id
    add_index :concert_tags, :piece_id
    add_index :concert_tags, :performer_id
  end
end
