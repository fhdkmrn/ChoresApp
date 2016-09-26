class LeaderboardController < ApplicationController
	def index
		@current_user = User.find_by(id: session[:user_id])
		if @current_user == nil
		  redirect_to '/login'
		end
		@users = User.order(points: :desc)
	end
end
