class ActivitiesController < ApplicationController

  helper ActivitiesHelper
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    if current_user.blank?
        redirect_to root_path
    else
      @activity = Activity.new

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
      end
    end
    
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    #@activity = Activity.new(params[:activity])
    @activity = current_user.activities.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    #@activity = Activity.find(params[:id])
    @activity = current_user.activities.find(params[:id])
    if params[:activity] && params[:activity].has_key?(:user_id)
      params[:activity].delete(:user_id) 
    end
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activityR = ActivityRequest.where(activity_id: @activity.id)
    if current_user==@activity.user
      @activity.destroy    
      @activityR.delete_all
      respond_to do |format|
        format.html { redirect_to activities_url }
        format.json { head :ok }
      end
    else
      redirect_to root_path
    end
  end
end
