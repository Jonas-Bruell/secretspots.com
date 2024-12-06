class CreateAdventures < ActiveRecord::Migration[7.2]
  def change
    create_table :adventures do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
