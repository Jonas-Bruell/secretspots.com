class CreateAdventures < ActiveRecord::Migration[7.2]
  def change
    create_table :adventures do |t|
      t.string :naam
      t.string :beschrijving
      t.integer :likes
      t.integer :amountOfSecrets

      t.timestamps
    end
  end
end
