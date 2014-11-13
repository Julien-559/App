class ProfilesController < ApplicationController
  def show
  	@user=User.find_by_profile_name(params[:id])
    @act1=ActivityRequest.where(user_id: @user.id, accepted: true)
  	@act=ActivityRequest.where(friend_id: @user.id) ##Activity.find_by_sql("SELECT 'activities'.* from activities a inner join activity_requests b on a.id=b.activity_id where b.friend_id= '#{@user.id}'")
  	#logger info "b"
  	#logger.info '#{@act}'
  	#logger.info "e"
  	if @user
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def edit
    @user=User.find_by_profile_name(params[:id])
    @requested_activities=ActivityRequest.where(user_id: @user.id)
  end
end
