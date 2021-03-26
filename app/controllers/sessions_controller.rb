# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @current_user = User.find_by(id: session[:user_id])
    redirect_to user_path unless @current_user.nil?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to user_path
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
