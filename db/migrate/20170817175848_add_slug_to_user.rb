class AddSlugToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slug, :string, uniq: true
  end
end
