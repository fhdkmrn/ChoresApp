# frozen_string_literal: true

desc 'This task is called by the Heroku scheduler add-on'
task update_chores: :environment do
  if Time.now.sunday?
    User.all.each do |user|
      user.choreCycle = (user.choreCycle + 1) % User.all.count
      chore = ChoresList.find_by(taskID: user.choreCycle)
      chore.user = user.name
      ChoresMailer.weekly_email(user).deliver_now
      user.approvalLists = []
      user.tradeRequests = []
    end
  end
end

task send_reminders: :environment do
  User.send_reminders
end
