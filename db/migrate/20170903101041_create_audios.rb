class CreateAudios < ActiveRecord::Migration[5.1]
  def change
    create_table :audios do |t|
      t.attachment :audio
      t.string :comment
      t.references :concert, foreign_key: true

      t.timestamps
    end
  end
end
