class Rate < ApplicationRecord
  #include Mongoid::Document
  #field :amount, :type => BigDecimal

  belongs_to :project
  belongs_to :user

  validates_presence_of :amount, :project, :user
  validates_numericality_of :amount, greater_than: 0
end