class TasksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  respond_to :html

  def show
    @task = Task.find(params[:id])
    @entries_exist = (@task.time_entries.count == 0) ? false : true
  end

  def create
    @project = Project.find(params[:project_id])

    @task = Task.new params[:task]
    @task.user = current_user
    @task.project = @project
    @task.save
    respond_with(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @project = @task.project

    @task.destroy
    respond_with(@project)
  end

  def edit
    @task = Task.find(params[:id])
    @project = @task.project

    respond_with(@task)
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    @project = @task.project

    respond_with(@project)
  end
end