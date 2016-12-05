class MigrateMembersFromMongoid < ActiveRecord::Migration[5.0]
  def up
    require 'csv'
    CSV.foreach("lib/migration/members.csv", headers: true) do |row|
      model = Member.new
      row.to_hash.keys.each do |key|
        if key == "_id"
          model.mongo_id = row["_id"]
        elsif key == "user_id"
          model.user = User.find_by_mongo_id(row["user_id"])
        elsif key == "project_id"
          model.project = Project.find_by_mongo_id(row["project_id"])
        else
          model.send("#{key}=", row[key]) if model.respond_to?("#{key}=")
        end
      end
      raise Exception.new "Did not save!" if !model.save
    end
  end

  def down
    Member.delete_all
  end
end
