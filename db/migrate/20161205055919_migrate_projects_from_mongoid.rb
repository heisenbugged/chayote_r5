class MigrateProjectsFromMongoid < ActiveRecord::Migration[5.0]
  def up
    require 'csv'
    CSV.foreach("lib/migration/projects.csv", headers: true) do |row|
      model = Project.new
      row.to_hash.keys.each do |key|
        if key == "_id"
          model.mongo_id = row["_id"]
        else
          model.send("#{key}=", row[key]) if model.respond_to?("#{key}=")
        end
      end
      raise Exception.new "Did not save!" if !model.save
    end
  end

  def down
    Project.delete_all
  end
end
