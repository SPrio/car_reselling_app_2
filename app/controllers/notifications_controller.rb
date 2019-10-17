class NotificationsController < ApplicationController
  #before_action :logged_in_user
  skip_before_action :verify_authenticity_token, only: [:mark_as_read]

  def index
    @notifications = Notification.where(recipient: current_user).unread.order("created_at DESC")
    # unless @notifications != []
    #   @notifications = Notification.where(recipient: current_user).last(10)
    # end
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    #binding.pry
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

  
end
