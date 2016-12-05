class InvoiceController < ApplicationController
  before_filter :authenticate_user!

  def new
    authorize! :invoice, current_user
    @projects = Project.all
  end
  def show
    authorize! :invoice, current_user
    set_dates

    @project = Project.find params[:project]
    @total_cost = 0
    @grouped_entries = {}

    tasks = Task.joins(:time_entries)
                .where("date >= ? and date <= ?", @start_date, @end_date)
                .select("tasks.*, SUM(hours) as task_hours")
                .group("tasks.id")

    tasks.each do |task|
      user = task.user
      if @grouped_entries[user.id].nil?
        @grouped_entries[user.id] = InvoiceUserMapping.new(user, @project)
      end
      @grouped_entries[user.id].add_task_mapping(task, task.task_hours)
      @total_cost += (task.task_hours*@grouped_entries[user.id].rate)
    end

    render layout: 'barebones'
  end

  private
  def set_dates
    if params[:start_date].class == Date
      @start_date = params[:start_date].to_time
    elsif params[:start_date].class == Time
      @start_date = params[:start_date]
    else
      @start_date = Time.parse(params[:start_date])
    end

    if params[:end_date].class == Date
      @end_date = params[:end_date].to_time
    elsif params[:end_date].class == Time
      @end_date = params[:end_date]
    else
      @end_date = Time.parse(params[:end_date])
    end
  end

end
