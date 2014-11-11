class ActivityRequest < ActiveRecord::Base
	belongs_to :activity
	belongs_to :user
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

	attr_accessible :activity, :user, :friend, :activity_id, :user_id, :friend_id, :accepted, :holding

	def send_request_email
		UserNotifier.activity_requested(id).deliver
	end


end
