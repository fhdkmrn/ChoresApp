# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def authorize
    redirect_to login_path unless current_user
  end

  def list_empty?
    !!ChoresList.all.count.zero?
  end

  def list_cycle
    chores = %w[sweeping bathroom cleaning wiping playing bye trying dying]
    chore = ChoresList.new
    (0..7).each do |i|
      chore.choreName = chores[i]
      chore.taskID = i
      chore.save
    end
  end
end
