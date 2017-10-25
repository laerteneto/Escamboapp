class AdminMailerPreview < ActionMailer::Preview

	def uptade_email
		AdminMailer.update_email(Admin.first, Admin.last)
	end

	def send_message
		AdminMailer.send_message(Admin.first, Admin.last, "Subject Test", "blablabla")
	end


end
