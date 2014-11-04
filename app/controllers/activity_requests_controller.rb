class ActivityRequestsController < ApplicationController

  	def new
		if params[:activity_id]
			@activity=Activity.find(params[:activity_id])
			@activity_request = current_user.activity_requests.new(activity: @activity)
		else
			flash[:error] = "Friend required"
		end
	end


end
