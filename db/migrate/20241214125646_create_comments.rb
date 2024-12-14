class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :secret, null: false, foreign_key: true
      t.text :content
      t.boolean :edited, default: false

      t.timestamps
    end
  end
end
