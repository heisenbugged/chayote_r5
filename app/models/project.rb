class Project < ApplicationRecord
  #include Mongoid::Document
  #field :name

  has_many :members, dependent: :destroy
  has_many :tasks,   dependent: :destroy
  has_many :time_entries, through: :tasks


  def users
    members.collect{ |member| member.user }
  end

  def has_user?(user)
    users = members.collect{ |member| member.user }
    users.include?(user)
  end

  # Should be called tasks_for_user or just tasks_for
  def user_tasks(user)
    tasks.where(user_id: user.id)
  end

  def tasks_for_dates(start_date, end_date)
  end
end