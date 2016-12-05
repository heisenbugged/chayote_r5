class Admin::UsersController < ApplicationController
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    update! { admin_users_path }
  end
end
