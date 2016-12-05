# Code smell having to include application helper in this model..
include ApplicationHelper

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_presence_of :user, :project

  after_destroy :destroy_project_rate

  private
  # Project rates are created alongside members (inside the MembersController create action).
  # When a member is destroyed, the project rate needs to be destroyed as well.
  def destroy_project_rate
    if user
      rate = member_project_rate(self)
      rate.delete if rate
    end
  end
end