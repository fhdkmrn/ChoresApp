class SessionsController < ApplicationController
  def new
    @current_user = User.find_by(id: session[:user_id])
    if @current_user != nil
      redirect_to '/user'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/user'
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:danger] = 'Invalid email/password combination'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
