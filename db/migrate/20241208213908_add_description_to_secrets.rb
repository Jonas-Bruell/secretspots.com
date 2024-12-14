class AddDescriptionToSecrets < ActiveRecord::Migration[8.0]
  def change
    add_column :secrets, :description, :text
  end
end
