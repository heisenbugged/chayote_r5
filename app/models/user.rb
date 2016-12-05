class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :rates,        dependent: :destroy
  has_many :tasks,        dependent: :destroy
  has_many :time_entries, dependent: :destroy
  has_many :members,      dependent: :destroy
  has_many :projects,     through: :members

  def rate_for(object)
    if object.instance_of? Project
      # Probably an better way of doing this.
      rates.where(project_id: object.id).order("id desc").first
    end
  end

  def tasks_for_dates_and_project(start_date, end_date, project)
  	time_entries.joins(:task)
  				.where("date >= ? and date >= ?", start_date, end_date)
  				.where(tasks: {project_id: project.id})
  end

  def tasks_for_dates(start_date, end_date)
  	tasks.joins(:time_entries)
  		.where("date >= ? and date <= ?", start_date, end_date)
  		.group("tasks.id")
  end
end