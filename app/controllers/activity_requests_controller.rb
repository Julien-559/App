class ActivityRequestsController < ApplicationController

  	def new
		if params[:activity_id]
			@activity=Activity.find(params[:activity_id])
			@user=@activity.user
			logger.info "#{@activity}"
			@activity_request = @user.activity_requests.new(activity: @activity, friend: current_user)
		else
			flash[:error] = "Friend required"
		end
	end

	def create
	    if params[:activity_request] && params[:activity_request].has_key?(:activity_id)
	      @friend = current_user
	      logger.info "beggining"
	      logger.info "#{@friend}"
	      logger.info "end"
	      @activity=Activity.find(params[:activity_request][:activity_id])
	      @user = @activity.user
	      logger.info "beggining"
	      logger.info "#{@user}"
	      logger.info "end"
	      #@activity_request = ActivityRequest.new(user: @activity.user, activity: @activity, friend: @friend)
	      @activity_request = @user.activity_requests.new(activity: @activity, friend: @friend)
	      @activity_request.save
	      flash[:success] = "success"
	      redirect_to profile_path(@activity.user.profile_name)
	    else
	  		flash[:error] = "Didn't work"
	  		redirect_to root_path
	  	end
	    #   respond_to do |format|
	    #     if @user_friendship.new_record?
	    #       format.html do 
	    #         flash[:error] = "There was problem creating that friend request."
	    #         redirect_to profile_path(@friend)
	    #       end
	    #       format.json { render json: @user_friendship.to_json, status: :precondition_failed }
	    #     else
	    #       format.html do
	    #         flash[:success] = "Friend request sent."
	    #         redirect_to profile_path(@friend)
	    #       end
	    #       format.json { render json: @user_friendship.to_json }
	    #     end
	    #   end
	    # else
	    #   flash[:error] = "Friend required"
	    #   redirect_to root_path
	   #end

	    #if params[:activity_id]
	    # @activity=Activity.find(params[:activity_request][:activity_id])
	    # logger.info "#{@activity}"
	    # logger.info "apres"
	    # redirect_to profile_path(@activity.user.profile_name)
	end


end
