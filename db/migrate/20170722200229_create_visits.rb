class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :aasm_state
      t.references :user, foreign_key: true
      t.references :concert, foreign_key: true

      t.timestamps
    end
    add_index :visits, %i[user_id concert_id], unique: true
  end
end
