
class WeeklyController < ApplicationController

	def index
		@user = User.find_by(id: session[:user_id])
		if @user == nil
		  redirect_to '/login'
		end
		@users = User.order(points: :desc)
		chores = ["sweeping","bathroom","cleaning","wiping","playing","bye","trying","dying"]
		# For now, uninitialized choreslist
		if Choreslist.all.count == 0
			for i in 0..7
				chore = Choreslist.new
				chore.choreName = chores[i]
				chore.taskID = i
				chore.save

			end
		end
		chore = Choreslist.find_by(taskID:@user.choreCycle)
		chore.user = @user.name
		chore.save
		@current_chore = chore
     	@users = User.paginate(page: params[:page])

	end

	def problems
	end
end
