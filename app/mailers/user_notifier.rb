class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def activity_requested(activity_request_id)
  	activity_request = ActivityRequest.find(activity_request_id)
  	@user = activity_request.user
  	@friend = activity_request.friend

  	mail to: @user.email,
  		subject: "moi j'aime"
  end


end
