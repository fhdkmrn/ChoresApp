class HomepageController < ApplicationController
	def index
		@user = User.find_by(id: session[:user_id])
		if @user != nil
		  redirect_to '/user'
		end
		@users = User.order(points: :desc)
	end
end
