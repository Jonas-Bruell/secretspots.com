class CreateSecretTags < ActiveRecord::Migration[8.0]
  def change
    create_table :secret_tags do |t|
      t.string :name
      t.references :secret, null: false, foreign_key: true

      t.timestamps
    end
  end
end
