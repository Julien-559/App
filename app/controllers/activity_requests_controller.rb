class ActivityRequestsController < ApplicationController

  	def new
		if params[:activity_id]
			@activity=Activity.find(params[:activity_id])
			@user=@activity.user
			logger.info "#{@activity}"
			if ActivityRequest.where(activity_id: @activity.id, friend_id: current_user.id).blank?
				@activity_request = @user.activity_requests.new(activity: @activity, friend: current_user)
			else
				redirect_to feed_path
			end
			@activity_request = @user.activity_requests.new(activity: @activity, friend: current_user)
		else
			flash[:error] = "Friend required"
		end
	end

	def create
	    if params[:activity_request] && params[:activity_request].has_key?(:activity_id)
	      @friend = current_user
	      @activity=Activity.find(params[:activity_request][:activity_id])
	      @user = @activity.user
	      if ActivityRequest.where(activity_id: @activity.id, friend_id: current_user.id).blank?
	      	@activity_request = @user.activity_requests.new(activity: @activity, friend: @friend)
	      	@activity_request.save
	      	@activity_request.send_request_email
	      	flash[:success] = "success"
	      	redirect_to profile_path(@activity.user.profile_name)
	      else
	      	redirect_to feed_path
	      end
	    else
	  		flash[:error] = "Didn't work"
	  		redirect_to root_path
	  	end
	end

	def edit
		@activity_request = ActivityRequest.find(params[:id]) #.first
	end

	def accept
		@activity_request = ActivityRequest.find(params[:id])
	    @activity_request[:accepted] = true
	    logger.debug @activity_request.inspect
	    @activity_request.save
	    redirect_to profile_path(current_user.profile_name)
	end

	def block
		ActivityRequest.find(params[:id]).delete
		redirect_to profile_path(current_user.profile_name)
	end

	def destroy
		@actR = ActivityRequest.find(params[:id])
    	if current_user==@actR.user || current_user==@actR.friend
      		@actR.destroy
      		respond_to do |format|
        		format.html { redirect_to activities_url }
        		format.json { head :ok }
      		end
    	else
      		redirect_to root_path
    	end 
    end   


end
