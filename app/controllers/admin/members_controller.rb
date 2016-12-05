class Admin::MembersController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def create
    @project = Project.find(params[:member][:project])
    @user = User.find(params[:member][:user])

    unless params[:rate].blank?
      @rate = ProjectRate.new
      @rate.project = @project
      @rate.user = @user
      @rate.amount = params[:rate]
      @rate.save
    end

    @member = Member.new(project: @project, user: @user)
    @member.save

    redirect_to edit_admin_project_path(@project)
  end

  def destroy
    @member = Member.find params[:id]
    @project = @member.project

    # not sure if necessary. should be handled through some form of
    # dependent destroy assoiation at model level.
    ProjectRate.where(user_id: @member.user, project_id: @member.project)
               .each(&:destroy)
    @member.destroy

    redirect_to edit_admin_project_path(@project)
  end
end