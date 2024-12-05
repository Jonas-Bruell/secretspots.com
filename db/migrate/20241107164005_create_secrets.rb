class CreateSecrets < ActiveRecord::Migration[7.2]
  def change
    create_table :secrets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :Body

      t.timestamps
    end
  end
end
