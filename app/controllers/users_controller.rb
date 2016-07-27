class UsersController < ApplicationController

	def new
		@user = User.find_by(id: session[:user_id])
		if @user != nil
			redirect_to '/user'
		end
		@user = User.new
	end

	def show

		@user = User.find_by(id: session[:user_id])

		if @user == nil
		  redirect_to '/login'
		end
		@users = User.order(points: :desc)
	end

	def others
		chores = ["sweeping","bathroom","cleaning","wiping","playing","bye","trying","dying"]
		chore = nil
		@user = User.find(params[:id])

		if User.find_by(id: params[:id]).nil? 
			render "404.html"
		else 
			@user = User.find_by(id: params[:id])
		end
		@current_user = User.find_by(id: session[:user_id])
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
		if @user == nil
		  redirect_to '/login'
		end
		@users = User.order(points: :desc)
	end

	def approve
		@user = User.find_by(id: params[:id])
		@current_user = User.find_by(id: session[:user_id])
		chore = Choreslist.find_by(taskID:@user.choreCycle)
		@current_chore = chore
		if @user.approvalLists.include? "Done"
			flash[:notice] = "This user had been approved for this week already, he does not need your approval!"	

		else

		    if @user != @current_user
		    	if eval(@user.approvalLists).include? @current_user.name
				    flash[:notice] = "You have already approved this user!"
		    	else

					@user.approvalLists = eval(@user.approvalLists) + [@current_user.name]
					@user.points += 50
					if eval(@user.approvalLists).count >= 2
						@user.approvalLists = eval(@user.approvalLists) + ["Done"]
					end
					if @user.save
		    			flash[:notice] = "Successfully approved!"	
		    		else		
		    			flash[:notice] = @user.errors.full_messages
		    		end	

		    	end
	    	end
	    end
		redirect_to "/users/"+ @user.id.to_s
	end
	def trade
	    flash[:notice] = ""	

		@user = User.find_by(id: params[:id])
		@current_user = User.find_by(id: session[:user_id])
		chore = Choreslist.find_by(taskID:@user.choreCycle)
	    @current_chore = chore
	    if @user != @current_user && eval(@user.approvalLists).count < 2 && eval(@current_user.approvalLists).count < 2
	    	if eval(@user.tradeRequests).include? @current_user.name
			    flash.now[:notice] = "You have already requested trade with this user!"
			else

				@user.tradeRequests = eval(@user.tradeRequests) + [@current_user.name]
	    		if @user.save
	    			flash.now[:notice] = "Successfully Requested Trade!"
	    		else		
	    			flash[:notice] = @user.errors.full_messages
	    		end	
	    	end

	    end
		render "others"


	end

	def acceptTrade

		@user = User.find_by(id: session[:user_id])
		@secondUser = User.find_by(id: params[:id])
	
		@user.choreCycle, @secondUser.choreCycle = @secondUser.choreCycle, @user.choreCycle

		@user.tradeRequests = eval(@user.tradeRequests) - [@secondUser.name]
		@secondUser.acceptedTrade = [@user.name] + eval(@secondUser.acceptedTrade) 
		if @user.save && @secondUser.save
	    	flash[:notice] = "Successfully traded chores"
	    else		
	    	flash[:notice] = @secondUser.errors.full_messages
	    end	
		chore = Choreslist.find_by(taskID:@user.choreCycle)
		chore.user = @user.name
		choreTwo = Choreslist.find_by(taskID:@secondUser.choreCycle)
		choreTwo.user = @secondUser.name
		chore.save
		choreTwo.save
		redirect_to '/user'

	end

	def declineTrade
		@user = User.find_by(id: session[:user_id])
		@secondUser = User.find_by(id: params[:id])
	
		@user.tradeRequests = eval(@user.tradeRequests) - [@secondUser.name]
		@secondUser.declineTrade =  [@user.name] + eval(@secondUser.declineTrade)

		if @user.save && @secondUser.save
	    	flash[:notice] = "Successfully declined the Request"
	    else		
	    	flash[:notice] = @secondUser.errors.full_messages
	    end	

		render 'show'
	end

	def delete
		session[:user_id] = nil
	end



	def create
		user = User.new(user_params)
		if user.save
		  user.choreCycle = User.all.count-1
		  user.points = 0
		  user.approvalLists = []
		  user.tradeRequests = []
		  user.acceptedTrade = []
		  user.declinedTrade = []
		  user.save
		  session[:user_id] = user.id
		  ChoresMailer.welcome_email_first(user).deliver_now

		  redirect_to '/user'
		else
		  @user = user
		  render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :photo)
	end
end
