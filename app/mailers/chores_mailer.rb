class ChoresMailer < ApplicationMailer
	default from: "putnastychores@gmail.com"

	def welcome_email_first(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome!')
	end

	def weekly_email(user)
		@user = user
		mail(to: @user.email, subject: 'This Weeks Chores')
	end

end
