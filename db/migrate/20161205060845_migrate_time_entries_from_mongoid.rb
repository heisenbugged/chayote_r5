class MigrateTimeEntriesFromMongoid < ActiveRecord::Migration[5.0]
  def up
    require 'csv'
    CSV.foreach("lib/migration/time_entries.csv", headers: true) do |row|
      model = TimeEntry.new
      row.to_hash.keys.each do |key|
        if key == "_id"
          model.mongo_id = row["_id"]
        elsif key == "user_id"
          model.user = User.find_by_mongo_id(row["user_id"])
        elsif key == "task_id"
          model.task = Task.find_by_mongo_id(row["task_id"])
        else
          model.send("#{key}=", row[key]) if model.respond_to?("#{key}=")
        end
      end
      # do not raise exception as some do fail
      model.save
    end
  end

  def down
    TimeEntry.delete_all
  end
end
