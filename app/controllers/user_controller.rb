# frozen_string_literal: true

class UserController < ApplicationController
  def new
    @user = User.find_by(id: session[:user_id])
    redirect_to user_path unless @user.nil?
    @user = User.new
  end

  def show
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path if @user.nil?
    @users = User.order(points: :desc)
  end

  def others
    @user = User.find(params[:id])
    if User.find_by(id: params[:id]).nil?
      render status: 404
    else
      @user = User.find_by(id: params[:id])
    end
    @current_user = User.find_by(id: session[:user_id])
    list_cycle if list_empty?

    @current_chore = ChoresList.find_by(taskID: @user.choreCycle)
    return if @current_chore.nil?

    @current_chore.user = @user.name
    @current_chore.save!
    redirect_to login_path if @user.nil?
  end

  def approve
    @user = User.find_by(id: params[:id])
    @current_user = User.find_by(id: session[:user_id])
    chore = ChoresList.find_by(taskID: @user.choreCycle)
    @current_chore = chore
    if @user.approvalLists.include? 'Done'
      flash[:notice] = 'This user had been approved for this week already, he does not need your approval!'
    elsif @user != @current_user
      if @user.approvalLists.include? @current_user.name
        flash[:notice] = 'You have already approved this user!'
      else
        @user.approvalLists = @user.approvalLists + [@current_user.name]
        @user.points += 50
        @user.approvalLists = @user.approvalLists + ['Done'] if @user.approvalLists.count >= 2
        flash[:notice] = if @user.save
                           'Successfully approved!'
                         else
                           @user.errors.full_messages
                         end
      end
    end
    redirect_to user_path(:id)
  end

  def trade
    flash[:notice] = ''

    @user = User.find_by(id: params[:id])
    @current_user = User.find_by(id: session[:user_id])
    chore = ChoresList.find_by(taskID: @user.choreCycle)
    @current_chore = chore
    unless @user == @current_user && @user.approvalLists.size < 2 && @current_user.approvalLists.size < 2
      if @user.tradeRequests.include? @current_user.name
        flash.now[:notice] = 'You have already requested trade with this user!'
      else
        @user.tradeRequests = @user.tradeRequests + [@current_user.name]
        if @user.save
          flash.now[:notice] = 'Successfully Requested Trade!'
        else
          flash[:notice] = @user.errors.full_messages
        end
      end
    end
    render 'others'
  end

  def accept_trade
    @user = User.find_by(id: session[:user_id])
    @second_user = User.find_by(id: params[:id])

    @user.choreCycle, @second_user.choreCycle = @second_user.choreCycle, @user.choreCycle

    @user.tradeRequests = @user.tradeRequests - [@second_user.name]
    @second_user.acceptedTrade = [@user.name] + @second_user.acceptedTrade
    flash[:notice] = if @user.save && @second_user.save
                       'Successfully traded chores'
                     else
                       @second_user.errors.full_messages
                     end
    chore = ChoresList.find_by(taskID: @user.choreCycle)
    chore_two = ChoresList.find_by(taskID: @second_user.choreCycle)
    return if chore.nil? && chore_two.nil?

    chore.user = @user.name
    chore_two.user = @second_user.name
    chore.save!
    chore_two.save!
    redirect_to user_path
  end

  def decline_trade
    @user = User.find_by(id: session[:user_id])
    @second_user = User.find_by(id: params[:id])
    @user.tradeRequests = @user.tradeRequests - [@second_user.name]
    @second_user.declinedTrade = [@user.name] + @second_user.declinedTrade
    flash[:notice] = if @user.save && @second_user.save
                       'Successfully declined the Request'
                     else
                       @second_user.errors.full_messages
                     end
    render 'show'
  end

  def delete
    session[:user_id] = nil
  end

  def create
    user = User.new(user_params)
    if user.save!
      user.choreCycle = User.count - 1
      user.points = 0
      user.approvalLists = '[]'
      user.tradeRequests = '[]'
      user.acceptedTrade = '[]'
      user.declinedTrade = '[]'
      user.save!
      session[:user_id] = user.id
      ChoresMailer.welcome_email_first(user).deliver_now

      redirect_to user_path
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
