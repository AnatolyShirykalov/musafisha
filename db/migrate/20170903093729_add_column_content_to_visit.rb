class AddColumnContentToVisit < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :content, :text, null: false, default: ''
  end
end
