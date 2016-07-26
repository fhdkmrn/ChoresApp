class LeaderboardController < ApplicationController
	def index
		@user = User.find_by(id: session[:user_id])
		if @user == nil
		  redirect_to '/login'
		end
		@users = User.order(points: :desc)
	end
end
