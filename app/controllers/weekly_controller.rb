# frozen_string_literal: true

class WeeklyController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path if @user.nil?
    @users = User.order(points: :desc)
    chores = %w[sweeping bathroom cleaning wiping playing bye trying dying]
    # For now, uninitialized chores_list
    if ChoresList.all.count.zero?
      chore = ChoresList.new
      (0..7).each do |i|
        chore.choreName = chores[i]
        chore.taskID = i
        chore.save
      end
    end
    chore = ChoresList.find_by(taskID: @user.choreCycle)
    chore.user = @user.name
    chore.save
    @current_chore = chore
    @users = User.paginate(page: params[:page])
  end

  def events
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path if @user.nil?
  end

  def problems; end
end
