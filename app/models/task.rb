class Task < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  # field :name

  belongs_to :user
  belongs_to :project

  has_many :time_entries, dependent: :destroy
  validates_presence_of :name, :user, :project

  def most_recent_entry_date
    # "try" use is code smell
    time_entries.order("date desc").first.try(:date)
  end

  def hours
    time_entries.sum(:hours)
  end

  def total_hours_for_dates(start_date, end_date)
    time_entries.where("date >= ? and date <= ?", start_date, end_date)
                .sum(:hours)
  end
end
