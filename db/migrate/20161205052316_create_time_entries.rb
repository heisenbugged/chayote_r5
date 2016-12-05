class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.decimal :hours,     null: false, default: 0
      t.date    :date#,     null: false, default: (what default to set?)
      t.string  :mongo_id,  null: false, default: ""

      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :time_entries, :mongo_id, unique: true
  end
end
