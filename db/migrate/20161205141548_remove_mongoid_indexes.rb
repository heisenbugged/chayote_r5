class RemoveMongoidIndexes < ActiveRecord::Migration[5.0]
  def change
  	remove_index :users        , :mongo_id
  	remove_index :projects     , :mongo_id
  	remove_index :tasks        , :mongo_id
  	remove_index :time_entries , :mongo_id
  	remove_index :rates        , :mongo_id
  	remove_index :members      , :mongo_id
  end
end
