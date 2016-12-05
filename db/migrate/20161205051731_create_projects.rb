class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string  :name,     null: false, default: ""
      t.string  :mongo_id,  null: false, default: ""
    end

    add_index :projects, :name,     unique: true
    add_index :projects, :mongo_id, unique: true
  end
end
