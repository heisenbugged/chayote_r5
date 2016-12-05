class Admin::ProjectsController < ApplicationController
  #inherit_resources
  #actions :index, :new, :create, :edit, :update, :destroy, :show

  respond_to :html
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    @projects = Project.order("id desc")
  end

  def show
    @project = Project.find params[:id]
    @tasks = @project.tasks.order("id desc")
    @tasks_exist = (@tasks.count == 0) ? false : true
  end

  def update
    @project = Project.find params[:id]
    @project.users = params[:users] unless params[:users].blank?
    byebug
    #update! { admin_projects_url }
  end

  def create
    @project = Project.new params[:project]
    @project.save
    respond_with(:admin, @project)
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    respond_with(:admin, @project)
  end

  def add_user
    unless params[:user].blank?
      @project = Project.find(params[:id])
      @user = User.find(params[:user])

      @member = Member.new
      @member.user = @user
      @member.project = @project
      (params[:rate].blank?) ? @member.rate = @user.base_rate : @member.rate = params[:rate]
      @member.save

      redirect_to edit_admin_project_url @project
    else
      redirect_to edit_admin_project_url @project
    end
  end

  def remove_user
    @member = Member.find(params[:id])
    @member.delete
    redirect_to edit_admin_project_url @project
  end
end
