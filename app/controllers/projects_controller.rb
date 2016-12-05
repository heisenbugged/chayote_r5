class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @project = Project.find(params[:id])
    @tasks = @project.user_tasks(current_user)
    		  .order("created_at desc")
    		  .group_by(&:most_recent_entry_date)

    @tasks_exist = (@tasks.count == 0) ? false : true
  end
end
