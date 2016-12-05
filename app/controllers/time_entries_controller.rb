class TimeEntriesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def create
    params[:time_entry][:user_id] = current_user.id
    @task = Task.find params[:task_id]
    @time_entry = @task.time_entries.build params[:time_entry]

    @time_entry.save
    respond_with @task
  end

  def destroy
    @time_entry = TimeEntry.find(params[:id])
    @task = @time_entry.task

    @time_entry.destroy
    respond_with @task
  end
end
