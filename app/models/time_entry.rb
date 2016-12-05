class TimeEntry < ApplicationRecord
  #include Mongoid::Document
  #include Mongoid::Timestamps
  #field :date, :type => Date
  #field :hours, :type => BigDecimal

  belongs_to :user
  belongs_to :task

  validates_presence_of :user, :task
  validates_numericality_of :hours, greater_than: 0

  before_create :verify_date

  private
  def verify_date
    self.date = Time.now if date.blank?
  end
end