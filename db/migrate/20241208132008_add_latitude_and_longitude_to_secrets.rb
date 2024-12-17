class AddLatitudeAndLongitudeToSecrets < ActiveRecord::Migration[8.0]
  def change
    add_column :secrets, :latitude, :float
    add_column :secrets, :longitude, :float
  end
end
