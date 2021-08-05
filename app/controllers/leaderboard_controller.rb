# frozen_string_literal: true

class LeaderboardController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    redirect_to login_path if @current_user.nil?
    @users = User.order(points: :desc)
  end
end
