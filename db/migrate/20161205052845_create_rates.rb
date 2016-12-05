class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.decimal :amount,   null: false, default: 0
      t.string  :mongo_id, null: false, default: ""

      t.references :project, index: true, foreign_key: true
      t.references :user,    index: true, foreign_key: true
    end
    add_index :rates, :mongo_id, unique: true
  end
end
