class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      # ------------------
      # Non-devise fields.
      # ------------------
      t.string  :full_name,         null: false, default: ""
      t.decimal :base_rate,         null: false, default: 0
      t.boolean :admin,             null: false, default: false
      t.string  :mongo_id,          null: false, default: ""

      # --------------
      # Devise fields.
      # --------------
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email,    unique: true
    add_index :users, :mongo_id, unique: true
  end
end
