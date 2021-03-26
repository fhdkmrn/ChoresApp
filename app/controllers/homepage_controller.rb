# frozen_string_literal: true

class HomepageController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    redirect_to user_path unless @user.nil?
    @users = User.order(points: :desc)
  end
end
