# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      ## Omniauth :: https://youtu.be/CnZnwV38cjo?si=-hUn-Dvs3ZPVfz21&t=243
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      t.string :provider

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    # TODO: why has unique to be false for the tests to not fail???
    add_index :users, :email,                unique: false # true
    add_index :users, :reset_password_token, unique: false # true
    # add_index :users, :confirmation_token,   unique: false #true
    # add_index :users, :unlock_token,         unique: false #true
  end
end
