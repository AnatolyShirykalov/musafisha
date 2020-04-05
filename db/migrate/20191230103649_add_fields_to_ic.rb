class AddFieldsToIc < ActiveRecord::Migration[6.0]
  def change
    add_column :intoclassics_links, :content, :text
  end
end
