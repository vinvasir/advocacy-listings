class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @notifications = Notification.for(current_user).unread

    render jsonapi: Notification.for(current_user).unread,
        fields: { recipient: [:email], actor: [:email] }
  end

  def mark_as_read
    @notifications = Notification.for(current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

  def read_one
    @notification = Notification.find(params[:notification_id])
    if @notification.update(read_at: Time.zone.now)
      render json: {success: true}
    end
  end
end