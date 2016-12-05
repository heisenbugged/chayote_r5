class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string     :mongo_id, null: false, default: ""
      t.references :project,  index: true, foreign_key: true
      t.references :user,     index: true, foreign_key: true
    end
    add_index :members, :mongo_id, unique: true
  end
end
