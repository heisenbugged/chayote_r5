class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string  :name,      null: false, default: ""
      t.string  :mongo_id,  null: false, default: ""

      t.references :user,    index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :tasks, :mongo_id, unique: true
  end
end