class CreateSecrets < ActiveRecord::Migration[7.2]
  def change
    create_table :secrets do |t|
      t.string :naam
      t.string :beschrijving
      t.integer :likes

      t.timestamps
    end
  end
end
