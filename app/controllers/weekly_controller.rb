# frozen_string_literal: true

class WeeklyController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path if @user.nil?
    @users = User.order(points: :desc)
    # For now, uninitialized chores_list
    list_cycle if list_empty?
    @current_chore = ChoresList.find_by(taskID: @user.choreCycle)
    return if @current_chore.nil?

    @current_chore.user = @user.name
    @current_chore.save!
    @users = User.paginate(page: params[:page])
  end

  def events
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path if @user.nil?
  end
end
